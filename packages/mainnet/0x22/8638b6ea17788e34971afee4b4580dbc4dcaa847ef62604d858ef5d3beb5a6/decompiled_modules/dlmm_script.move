module 0x228638b6ea17788e34971afee4b4580dbc4dcaa847ef62604d858ef5d3beb5a6::dlmm_script {
    struct EventFetchBins has copy, drop, store {
        bins: vector<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>,
    }

    struct EventPairParams has copy, drop, store {
        params: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPairParameter,
    }

    struct EventPairLiquidity has copy, drop, store {
        shares: u64,
        liquidity: u256,
        x: u64,
        y: u64,
        bin_ids: vector<u32>,
        bin_x: vector<u64>,
        bin_y: vector<u64>,
    }

    struct EventPositionLiquidity has copy, drop, store {
        shares: u64,
        liquidity: u256,
        x_equivalent: u64,
        y_equivalent: u64,
        bin_ids: vector<u32>,
        bin_x_eq: vector<u64>,
        bin_y_eq: vector<u64>,
        bin_liquidity: vector<u256>,
    }

    public entry fun swap<T0, T1>(arg0: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v1;
        let v4 = v0;
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public entry fun create_pair<T0, T1>(arg0: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: u16, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>>(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::create_pair_by_preset<T0, T1>(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun fetch_bins<T0, T1>(arg0: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = EventFetchBins{bins: 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::fetch_bins<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<EventFetchBins>(v0);
    }

    public entry fun fetch_pair_params<T0, T1>(arg0: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>) {
        let v0 = EventPairParams{params: *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::params<T0, T1>(arg0)};
        0x2::event::emit<EventPairParams>(v0);
    }

    public entry fun mint_amounts<T0, T1>(arg0: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::mint_by_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(v1, arg7);
    }

    public entry fun mint_percent<T0, T1>(arg0: &mut 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: vector<u32>, arg7: vector<u64>, arg8: vector<u64>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::mint<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position::Position>(v1, arg9);
    }

    public entry fun pair_liquidity<T0, T1>(arg0: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>) {
        let v0 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::fetch_bins<T0, T1>(arg0, 0, 9223372036854775808);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u32>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&v0)) {
            let v8 = 0x1::vector::borrow<0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::Bin>(&v0, v7);
            0x1::vector::push_back<u32>(&mut v3, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::storage_id(v8));
            v1 = v1 + 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v8);
            v2 = v2 + 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v8);
            0x1::vector::push_back<u64>(&mut v4, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v8));
            0x1::vector::push_back<u64>(&mut v5, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v8));
            v6 = v6 + 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::bin_total_supply<T0, T1>(arg0, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::storage_id(v8));
            v7 = v7 + 1;
        };
        let v9 = EventPairLiquidity{
            shares    : v6,
            liquidity : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::liquidity<T0, T1>(arg0),
            x         : v1,
            y         : v2,
            bin_ids   : v3,
            bin_x     : v4,
            bin_y     : v5,
        };
        0x2::event::emit<EventPairLiquidity>(v9);
    }

    public entry fun position_liquidity<T0, T1>(arg0: &0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::DlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = *0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_ids(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::position_manager<T0, T1>(arg0), arg1));
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u256>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(&v0)) {
            let v8 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::borrow_bin<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v7));
            let v9 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_y(v8);
            let v10 = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_share(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::position_manager<T0, T1>(arg0), arg1), *0x1::vector::borrow<u32>(&v0, v7));
            let (v11, v12) = 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::get_amount_out_of_bin(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_bin::reserve_x(v8), v9, v10, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::bin_total_supply<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v7)));
            0x1::vector::push_back<u64>(&mut v4, v11);
            0x1::vector::push_back<u64>(&mut v5, v12);
            v1 = v1 + v11;
            v2 = v2 + v12;
            v3 = v3 + v10;
            0x1::vector::push_back<u256>(&mut v6, 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::bin_liquidity(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::position_manager<T0, T1>(arg0), arg1), *0x1::vector::borrow<u32>(&v0, v7)));
            v7 = v7 + 1;
        };
        let v13 = EventPositionLiquidity{
            shares        : v3,
            liquidity     : 0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::liquidity(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_position_info::position_info(0xb3a44310c59536782d1b5c29d01a066798750ff0c15242a7f3eb7e55d188cfc3::dlmm_pair::position_manager<T0, T1>(arg0), arg1)),
            x_equivalent  : v1,
            y_equivalent  : v2,
            bin_ids       : v0,
            bin_x_eq      : v4,
            bin_y_eq      : v5,
            bin_liquidity : v6,
        };
        0x2::event::emit<EventPositionLiquidity>(v13);
    }

    // decompiled from Move bytecode v6
}

