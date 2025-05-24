module 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::pool_factory {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PoolCreatedWithLP has copy, drop {
        pool_id: 0x2::object::ID,
        lp_metadata_id: 0x2::object::ID,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::Global, arg1: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::create_pool_with_lp_type<T0, T1, LP<T0, T1>>(arg0, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::get_lp_info(arg0, v1);
        0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::lp_registry::add_lp_token(arg1, 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::lp_registry::create_lp_token_entry(v1, 0x2::object::id_from_address(@0x0), 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_metadata_id(v2), 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_name(v2), 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_symbol(v2), 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_description(v2), 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_icon_url(v2), 9, 0));
        let v3 = PoolCreatedWithLP{
            pool_id        : v1,
            lp_metadata_id : 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_metadata_id(v2),
            coin_x_type    : 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_coin_x_type(v2),
            coin_y_type    : 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::lp_info_coin_y_type(v2),
        };
        0x2::event::emit<PoolCreatedWithLP>(v3);
    }

    public entry fun create_token_pair_pool<T0, T1>(arg0: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::Global, arg1: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun create_usdc_sui_pool<T0>(arg0: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::Global, arg1: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, b"USDC-SUI LP", b"USDC-SUI-LP", b"Liquidity Provider token for USDC-SUI pool", b"", arg6, arg7, arg8);
    }

    public entry fun create_weth_sui_pool<T0>(arg0: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::amm::Global, arg1: &mut 0xd74c24cb02ce4f9d5d447f78e902c3b88b458ec4b8c2ee7313c02f47266e0ac7::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, b"WETH-SUI LP", b"WETH-SUI-LP", b"Liquidity Provider token for WETH-SUI pool", b"", arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

