module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::treasury {
    struct BackerYieldPool has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        total_yield_bps: u64,
        last_distributed: u64,
    }

    struct BackerYieldKey has copy, drop, store {
        pass_id: 0x2::object::ID,
    }

    public entry fun claim_yield<T0>(arg0: &mut BackerYieldPool, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer::BackerPass, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = b"balance";
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 500);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 > 0, 500);
        let v3 = v2 * 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer::yield_share_bps(arg1) / 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::bps_denominator();
        assert!(v3 > 0, 500);
        let v4 = 0x2::tx_context::sender(arg2);
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_yield_claimed(arg0.launch_id, v4, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v3), arg2), v4);
    }

    public fun create_yield_pool(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = BackerYieldPool{
            id               : v0,
            launch_id        : arg0,
            total_yield_bps  : arg1,
            last_distributed : 0,
        };
        0x2::transfer::share_object<BackerYieldPool>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public entry fun distribute_fees<T0, T1>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::amm::Pool<T0, T1>, arg1: &mut BackerYieldPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::amm::collect_fees<T0, T1>(arg0);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"balance")) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"balance"), v0);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut arg1.id, b"balance", v0);
        };
    }

    // decompiled from Move bytecode v7
}

