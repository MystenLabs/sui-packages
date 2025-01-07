module 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::pool {
    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        enable: bool,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        fee_x: 0x2::balance::Balance<T0>,
        fee_y: 0x2::balance::Balance<T1>,
        dao_fee: u64,
        lp_fee: u64,
        locked_lp: 0x2::balance::Balance<LPCoin<T0, T1>>,
        lp_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LPCoin<T0, T1>>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 0);
        assert!(v1 > 0, 0);
        let (v2, v3, v4) = get_reserve<T0, T1>(arg0);
        let (v5, v6) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_no_loss_values(arg3, arg5, arg4, arg6, v2, v3);
        let v7 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_lp_coin_by_coinx_coiny_amount(v5, v6, (v4 as u128), v2, v3);
        assert!(0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1)) < 1844674407370955 && 0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg2)) < 1844674407370955, 1);
        let v8 = 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut arg0.lp_supply, v7);
        let v9 = v7;
        if (v4 == 0) {
            let v10 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::constants::get_min_lp_value();
            0x2::balance::join<LPCoin<T0, T1>>(&mut arg0.locked_lp, 0x2::balance::split<LPCoin<T0, T1>>(&mut v8, v10));
            v9 = v7 - v10;
        };
        0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::events::emit_add_lp_event<T0, T1>(0x2::tx_context::sender(arg7), v9, arg3, arg5, v5, v6, v2, v3, v4);
        (0x2::coin::from_balance<LPCoin<T0, T1>>(v8, arg7), 0x2::coin::split<T0>(&mut arg1, v0 - v5, arg7), 0x2::coin::split<T1>(&mut arg2, v1 - v6, arg7))
    }

    public(friend) fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::constants::get_default_fee();
        let v2 = LPCoin<T0, T1>{dummy_field: false};
        let v3 = Pool<T0, T1>{
            id        : 0x2::object::new(arg0),
            enable    : true,
            reserve_x : 0x2::balance::zero<T0>(),
            reserve_y : 0x2::balance::zero<T1>(),
            fee_x     : 0x2::balance::zero<T0>(),
            fee_y     : 0x2::balance::zero<T1>(),
            dao_fee   : v0,
            lp_fee    : v1,
            locked_lp : 0x2::balance::zero<LPCoin<T0, T1>>(),
            lp_supply : 0x2::balance::create_supply<LPCoin<T0, T1>>(v2),
        };
        let v4 = 0x2::object::id<Pool<T0, T1>>(&v3);
        0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::events::emit_create_pool_event<T0, T1>(0x2::tx_context::sender(arg0), v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v3);
        v4
    }

    public(friend) fun decrease_liquidity_by_lpcoin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LPCoin<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::coin::value<LPCoin<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserve<T0, T1>(arg0);
        let (v4, v5) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_coinx_coiny_by_lp_coin(v0, v1, v2, (v3 as u128));
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg1));
        0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::events::emit_remove_lp_event<T0, T1>(0x2::tx_context::sender(arg4), v0, arg2, arg3, v4, v5, v1, v2, v3);
        (0x2::coin::take<T0>(&mut arg0.reserve_x, v4, arg4), 0x2::coin::take<T1>(&mut arg0.reserve_y, v5, arg4), v4, v5)
    }

    public fun get_reserve<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg0.lp_supply))
    }

    public entry fun set_dao_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::Global, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::get_manager_address(arg1);
        assert!(v1 == v0 || v2 == v0, 1);
        arg0.dao_fee = arg2;
    }

    public entry fun set_lp_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::Global, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::get_manager_address(arg1);
        assert!(v1 == v0 || v2 == v0, 1);
        arg0.lp_fee = arg2;
    }

    public(friend) fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_fee(v0, arg0.dao_fee);
        let v2 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_fee(v0, arg0.lp_fee);
        0x2::coin::put<T0>(&mut arg0.fee_x, 0x2::coin::split<T0>(&mut arg1, v1, arg3));
        let (v3, v4, _) = get_reserve<T0, T1>(arg0);
        assert!(v3 > 0 && v4 > 0, 2);
        let v6 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_amount_out(v0 - v1 - v2, v3, v4);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::events::emit_swap_event<T0, T1>(0x2::tx_context::sender(arg3), v0, v6, arg2, v1, v2, v3, v4);
        (0x2::coin::take<T1>(&mut arg0.reserve_y, v6, arg3), v6)
    }

    public(friend) fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_fee(v0, arg0.dao_fee);
        let v2 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_fee(v0, arg0.lp_fee);
        0x2::coin::put<T1>(&mut arg0.fee_y, 0x2::coin::split<T1>(&mut arg1, v1, arg3));
        let (v3, v4, _) = get_reserve<T0, T1>(arg0);
        assert!(v3 > 0 && v4 > 0, 2);
        let v6 = 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::core_amm::get_amount_out(v0 - v1 - v2, v4, v3);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg1));
        0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::events::emit_swap_event<T0, T1>(0x2::tx_context::sender(arg3), v0, v6, arg2, v1, v2, v3, v4);
        (0x2::coin::take<T0>(&mut arg0.reserve_x, v6, arg3), v6)
    }

    public entry fun withdraw_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::Global, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global::get_withdraw_address(arg1) == 0x2::tx_context::sender(arg5), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_x, arg3), arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_y, arg4), arg5), arg2);
    }

    // decompiled from Move bytecode v6
}

