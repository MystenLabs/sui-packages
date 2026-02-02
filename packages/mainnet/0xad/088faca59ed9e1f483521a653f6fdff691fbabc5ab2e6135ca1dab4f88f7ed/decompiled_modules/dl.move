module 0xad088faca59ed9e1f483521a653f6fdff691fbabc5ab2e6135ca1dab4f88f7ed::dl {
    public fun la<T0, T1>(arg0: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg5, arg6, arg8);
        let (v2, v3, v4) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8);
        let v5 = v2;
        0x2::coin::join<T0>(&mut v5, v4);
        if (0x2::coin::value<T0>(&v5) >= arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg5, 0x2::coin::split<T0>(&mut v5, arg6, arg8), v1);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T0>(v5, arg8);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T1>(v3, arg8);
        } else {
            let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg5, v3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
            0x2::coin::join<T0>(&mut v5, v6);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg5, 0x2::coin::split<T0>(&mut v5, arg6, arg8), v1);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T0>(v5, arg8);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T1>(v7, arg8);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8, arg8);
        };
    }

    public fun lb<T0, T1>(arg0: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg5, arg6, arg8);
        let (v2, v3, v4) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8);
        let v5 = v3;
        0x2::coin::join<T1>(&mut v5, v4);
        if (0x2::coin::value<T1>(&v5) >= arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg5, 0x2::coin::split<T1>(&mut v5, arg6, arg8), v1);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T0>(v2, arg8);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T1>(v5, arg8);
        } else {
            let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg5, v2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg8), 0, arg7, arg8);
            0x2::coin::join<T1>(&mut v5, v7);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg5, 0x2::coin::split<T1>(&mut v5, arg6, arg8), v1);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T0>(v6, arg8);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<T1>(v5, arg8);
            0xa332bbd7534f3eb4afac01593c829067c3b296057a44714c5039ab7769daf19b::vv::td<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8, arg8);
        };
    }

    // decompiled from Move bytecode v6
}

