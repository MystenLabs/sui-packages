module 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::interface {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg0);
        let v0 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>();
        let (v1, v2) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::add_liquidity<T0, T1>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::get_mut_pool<T0, T1>(arg0, v0), arg1, arg2, arg3, arg4, v0, arg5);
        let v3 = v2;
        assert!(0x1::vector::length<u64>(&v3) == 3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>>(v1, 0x2::tx_context::sender(arg5));
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_add_liquidity_event(0x2::tx_context::sender(arg5), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v3), 0x1::vector::pop_back<u64>(&mut v3), 0x1::vector::pop_back<u64>(&mut v3));
    }

    public entry fun emergency_unstake_lp<T0, T1, T2>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::StakePool<T0, T1, T2>, arg1: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::emergency_unstake_lp<T0, T1, T2>(arg0, arg1, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun harvest<T0, T1, T2>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::StakePool<T0, T1, T2>, arg1: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg1);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg1);
        let v0 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::harvest<T0, T1, T2>(arg0, arg1, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), 0x2::clock::timestamp_ms(arg2), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg3));
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_harvest_lp_event(0x2::tx_context::sender(arg3), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_token_name<T2>(), 0x2::coin::value<T2>(&v0));
    }

    public entry fun stake_lp<T0, T1, T2>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::StakePool<T0, T1, T2>, arg1: 0x2::coin::Coin<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>, arg2: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::stake_lp<T0, T1, T2>(arg0, arg1, arg2, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), 0x2::clock::timestamp_ms(arg3), arg4);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_stake_lp_event(0x2::tx_context::sender(arg4), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_token_name<T2>(), 0x2::coin::value<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>(&arg1));
    }

    public entry fun unstake_lp<T0, T1, T2>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::StakePool<T0, T1, T2>, arg1: u64, arg2: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::unstake_lp<T0, T1, T2>(arg0, arg1, arg2, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), 0x2::clock::timestamp_ms(arg3), arg4), 0x2::tx_context::sender(arg4));
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_unstake_lp_event(0x2::tx_context::sender(arg4), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_token_name<T2>(), arg1);
    }

    public entry fun remove_liquidty<T0, T1>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg1: 0x2::coin::Coin<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg0);
        let v0 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>();
        let (v1, v2) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::remove_liquidity<T0, T1>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::get_mut_pool<T0, T1>(arg0, v0), arg1, v0, arg2);
        let v3 = v2;
        let v4 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg2));
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_remove_liquidity_event(0x2::tx_context::sender(arg2), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v4), 0x2::coin::value<T1>(&v3), 0x2::coin::value<0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::LP<T0, T1>>(&arg1));
    }

    public entry fun swap_coins_for_exact_coins<T0, T1>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg0);
        let v0 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>();
        let v1 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::get_amounts_in<T0, T1>(arg0, arg2, v0);
        assert!(v1 <= arg3, 3);
        if (v0) {
            let (v2, v3) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, v1, arg4), 0x2::coin::zero<T1>(arg4), arg4);
            0x2::coin::destroy_zero<T0>(v2);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg4));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_swap_event(0x2::tx_context::sender(arg4), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), v1, 0, 0, arg2);
        } else {
            let (v4, v5) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T1, T0>(arg0, 0x2::coin::zero<T1>(arg4), 0x2::coin::split<T0>(&mut arg1, v1, arg4), arg4);
            0x2::coin::destroy_zero<T0>(v5);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg4));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_swap_event(0x2::tx_context::sender(arg4), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0, arg2, v1, 0);
        };
    }

    public entry fun swap_coins_for_exact_coins_two_pair<T0, T1, T2>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg0);
        let v0 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::get_amounts_in_two_pairs<T0, T1, T2>(arg0, arg2);
        assert!(v0 <= arg3, 3);
        let v1 = if (0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>()) {
            let (v2, v3) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, v0, arg4), 0x2::coin::zero<T1>(arg4), arg4);
            0x2::coin::destroy_zero<T0>(v2);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            v3
        } else {
            let (v4, v5) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T1, T0>(arg0, 0x2::coin::zero<T1>(arg4), 0x2::coin::split<T0>(&mut arg1, v0, arg4), arg4);
            0x2::coin::destroy_zero<T0>(v5);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            v4
        };
        let v6 = if (0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T1, T2>()) {
            let (v7, v8) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T1, T2>(arg0, v1, 0x2::coin::zero<T2>(arg4), arg4);
            0x2::coin::destroy_zero<T1>(v7);
            v8
        } else {
            let (v9, v10) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T2, T1>(arg0, 0x2::coin::zero<T2>(arg4), v1, arg4);
            0x2::coin::destroy_zero<T1>(v10);
            v9
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0x2::tx_context::sender(arg4));
    }

    public entry fun swap_exact_coins_for_coins<T0, T1>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg0);
        if (0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>()) {
            let (v0, v1) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg4), 0x2::coin::zero<T1>(arg4), arg4);
            let v2 = v1;
            0x2::coin::destroy_zero<T0>(v0);
            let v3 = 0x2::coin::value<T1>(&v2);
            assert!(v3 >= arg3, 4);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg4));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_swap_event(0x2::tx_context::sender(arg4), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), arg2, 0, 0, v3);
        } else {
            let (v4, v5) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T1, T0>(arg0, 0x2::coin::zero<T1>(arg4), 0x2::coin::split<T0>(&mut arg1, arg2, arg4), arg4);
            let v6 = v4;
            0x2::coin::destroy_zero<T0>(v5);
            let v7 = 0x2::coin::value<T1>(&v6);
            assert!(v7 >= arg3, 4);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg4));
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_swap_event(0x2::tx_context::sender(arg4), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0, v7, arg2, 0);
        };
    }

    public entry fun swap_exact_coins_for_coins_two_pair<T0, T1, T2>(arg0: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg0);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_version(arg0);
        let v0 = if (0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>()) {
            let (v1, v2) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg4), 0x2::coin::zero<T1>(arg4), arg4);
            0x2::coin::destroy_zero<T0>(v1);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            v2
        } else {
            let (v3, v4) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T1, T0>(arg0, 0x2::coin::zero<T1>(arg4), 0x2::coin::split<T0>(&mut arg1, arg2, arg4), arg4);
            0x2::coin::destroy_zero<T0>(v4);
            0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::return_remaining_coin<T0>(arg1, arg4);
            v3
        };
        let v5 = if (0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T1, T2>()) {
            let (v6, v7) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T1, T2>(arg0, v0, 0x2::coin::zero<T2>(arg4), arg4);
            let v5 = v7;
            0x2::coin::destroy_zero<T1>(v6);
            assert!(0x2::coin::value<T2>(&v5) >= arg3, 4);
            v5
        } else {
            let (v8, v9) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::internal_swap_coins_for_coins<T2, T1>(arg0, 0x2::coin::zero<T2>(arg4), v0, arg4);
            let v5 = v8;
            0x2::coin::destroy_zero<T1>(v9);
            assert!(0x2::coin::value<T2>(&v5) >= arg3, 4);
            v5
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

