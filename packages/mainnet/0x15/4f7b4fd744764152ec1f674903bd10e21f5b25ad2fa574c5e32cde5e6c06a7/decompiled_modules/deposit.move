module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::deposit {
    struct DepositKey has copy, drop, store {
        buyer: address,
    }

    struct UserDeposit has store {
        launch_id: 0x2::object::ID,
        buyer: address,
        amount_deposited: u64,
        passes_used: u64,
        tokens_claimable: u64,
        tokens_claimed: u64,
        vesting_start: u64,
    }

    struct PoolBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun buy<T0>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        buy_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun buy_internal<T0>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::status(arg0) == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_funding(), 100);
        assert!(v0 >= 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::deposit_open(arg0), 101);
        assert!(v0 < 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::deposit_close(arg0), 101);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::individual_deposit_cap(arg0), 200);
        let v3 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::id(arg0);
        let v4 = v2 * 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::platform_fee_bps(arg1) / 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::bps_denominator();
        let v5 = v2 * 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::project_fee_bps(arg1) / 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::bps_denominator();
        let v6 = 0x2::coin::into_balance<T0>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg4), 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::platform_treasury(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v5), arg4), 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::creator(arg0));
        let v7 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::uid_mut(arg0);
        let v8 = DepositKey{buyer: v1};
        assert!(!0x2::dynamic_field::exists_<DepositKey>(v7, v8), 202);
        let v9 = PoolBalanceKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PoolBalanceKey>(v7, v9)) {
            let v10 = PoolBalanceKey{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<PoolBalanceKey, 0x2::balance::Balance<T0>>(v7, v10), v6);
        } else {
            let v11 = PoolBalanceKey{dummy_field: false};
            0x2::dynamic_field::add<PoolBalanceKey, 0x2::balance::Balance<T0>>(v7, v11, v6);
        };
        let v12 = UserDeposit{
            launch_id        : v3,
            buyer            : v1,
            amount_deposited : v2,
            passes_used      : 0,
            tokens_claimable : 0,
            tokens_claimed   : 0,
            vesting_start    : 0,
        };
        0x2::dynamic_field::add<DepositKey, UserDeposit>(v7, v8, v12);
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::add_deposit(arg0, v2, v4, v5);
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_deposited(v3, v1, v2, v4, v5, v2 - v4 - v5);
    }

    public entry fun buy_with_pass<T0>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer::BackerPass, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer::launch_id(arg3) == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::id(arg0), 302);
        assert!(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer::passes_used(arg3) < 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::max_backer_passes(arg0), 201);
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer::use_pass(arg3, arg0);
        buy_internal<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public fun claimable_now(arg0: &UserDeposit, arg1: u64, arg2: u64) : u64 {
        if (arg0.vesting_start == 0) {
            return 0
        };
        if (arg1 <= arg0.vesting_start) {
            return 0
        };
        let v0 = arg0.tokens_claimable * (arg1 - arg0.vesting_start) / (arg2 - arg0.vesting_start);
        let v1 = if (v0 > arg0.tokens_claimable) {
            arg0.tokens_claimable
        } else {
            v0
        };
        if (v1 > arg0.tokens_claimed) {
            v1 - arg0.tokens_claimed
        } else {
            0
        }
    }

    public fun get_deposit(arg0: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: address) : &UserDeposit {
        let v0 = DepositKey{buyer: arg1};
        0x2::dynamic_field::borrow<DepositKey, UserDeposit>(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::borrow_uid(arg0), v0)
    }

    public fun set_vesting_info(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: address, arg2: u64, arg3: u64) {
        let v0 = DepositKey{buyer: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<DepositKey, UserDeposit>(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::uid_mut(arg0), v0);
        v1.tokens_claimable = arg2;
        v1.vesting_start = arg3;
    }

    // decompiled from Move bytecode v7
}

