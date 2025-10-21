module 0xc1fd6c76eb136ecdc9d535df1d20ddf1ba94ee250b8695d88384a20820171d8e::defi_verifier {
    public fun debug_get_type_name<T0>(arg0: &0x2::coin::Coin<T0>) : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun max(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun verify_defi_coin<T0>(arg0: &0x2::coin::Coin<T0>) : u8 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        max(0, 0xc1fd6c76eb136ecdc9d535df1d20ddf1ba94ee250b8695d88384a20820171d8e::scallop_checker::check(&v0, 0x2::coin::value<T0>(arg0)))
    }

    public fun verify_navi_any(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0x2::tx_context::TxContext) : u8 {
        0xc1fd6c76eb136ecdc9d535df1d20ddf1ba94ee250b8695d88384a20820171d8e::navi_checker::check_any_asset(arg0, 0x2::tx_context::sender(arg1))
    }

    public fun verify_navi_usdc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0x2::tx_context::TxContext) : u8 {
        0xc1fd6c76eb136ecdc9d535df1d20ddf1ba94ee250b8695d88384a20820171d8e::navi_checker::check_usdc(arg0, 0x2::tx_context::sender(arg1))
    }

    // decompiled from Move bytecode v6
}

