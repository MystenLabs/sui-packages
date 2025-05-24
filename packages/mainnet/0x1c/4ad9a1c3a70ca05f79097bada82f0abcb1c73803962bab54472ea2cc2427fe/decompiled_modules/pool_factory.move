module 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::pool_factory {
    struct POOL_FACTORY has drop {
        dummy_field: bool,
    }

    struct PoolCreatedWithLP has copy, drop {
        pool_id: 0x2::object::ID,
        lp_metadata_id: 0x2::object::ID,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::Global, arg1: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::create_pool_balance_based<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v1 = 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::get_lp_info(arg0, v0);
        0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry::add_lp_token(arg1, 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry::create_lp_token_entry(v0, 0x2::object::id_from_address(@0x0), 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_metadata_id(v1), 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_name(v1), 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_symbol(v1), 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_description(v1), 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_icon_url(v1), 9, 0));
        let v2 = PoolCreatedWithLP{
            pool_id        : v0,
            lp_metadata_id : 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_metadata_id(v1),
            coin_x_type    : 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_coin_x_type(v1),
            coin_y_type    : 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::lp_info_coin_y_type(v1),
        };
        0x2::event::emit<PoolCreatedWithLP>(v2);
    }

    public entry fun create_token_pair_pool<T0, T1>(arg0: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::Global, arg1: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun create_usdc_sui_pool<T0>(arg0: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::Global, arg1: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, b"USDC-SUI LP", b"USDC-SUI-LP", b"Liquidity Provider token for USDC-SUI pool", b"", arg6, arg7, arg8);
    }

    public entry fun create_weth_sui_pool<T0>(arg0: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::amm::Global, arg1: &mut 0x1c4ad9a1c3a70ca05f79097bada82f0abcb1c73803962bab54472ea2cc2427fe::lp_registry::LPRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        create_pool<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, b"WETH-SUI LP", b"WETH-SUI-LP", b"Liquidity Provider token for WETH-SUI pool", b"", arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

