//<?php
/**
 * customSettings
 * 
 * Plugin to add your system settings
 *
 * @category    plugin
 * @version     1.1
 * @author      Andchir <andchir@gmaail.com>
 * @internal    @properties &settings=Settings;textarea;Example custom setting~custom_st_example
 * @internal    @events OnSiteSettingsRender
 * @internal    @modx_category
 * @internal    @installset base
 * @internal    @disabled 1
 */

/**
 * Использование:
 * 
 * Company phone~company_phone||Company address~company_address~textarea
 * 
 * В шаблонах и чанках:
 * [(company_phone)]
 * [(company_address)]
 * 
 * В php-коде:
 * $modx->config['company_phone']
 * $modx->config['company_address']
 */

$e = &$modx->Event;
$output = "";

if ($e->name == 'OnSiteSettingsRender'){

    $settingsArr = !empty($settings) ? explode('||',$settings) : array('Example custom setting~custom_st_example');

    $output .= '<table>';

    foreach($settingsArr as $key => $st_row){
        $st_label_arr = explode('~',$st_row);
        $custom_st_label = trim($st_label_arr[0]);
        $custom_st_name = isset($st_label_arr[1]) ? $st_label_arr[1] : 'custom_st';
        $custom_st_type = isset($st_label_arr[2]) ? $st_label_arr[2] : 'input';
        $custom_st_value = isset($st_label_arr[1]) && isset($modx->config[$st_label_arr[1]]) ? trim($modx->config[$st_label_arr[1]]) : '';
        $output .= '
          <tr>
            <td nowrap="nowrap" class="warning" width="200">'.$custom_st_label.'</td>';
        if($custom_st_type=='textarea'){
            $output .= '<td><textarea name="'.$custom_st_name.'" style="width: 350px;" onchange="documentDirty=true;">'.$custom_st_value.'</textarea></td>';
        }else{
            $output .= '<td><input type="text" value="'.$custom_st_value.'" name="'.$custom_st_name.'" style="width: 350px;" onchange="documentDirty=true;" /></td>';
        }
        $output .= '
          </tr>
        ';
    }

    $output .= '</table>';
}
$e->output($output);
