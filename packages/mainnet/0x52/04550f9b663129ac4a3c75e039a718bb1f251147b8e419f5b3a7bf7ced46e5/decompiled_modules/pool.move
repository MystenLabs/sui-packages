module 0x5204550f9b663129ac4a3c75e039a718bb1f251147b8e419f5b3a7bf7ced46e5::pool {
    struct PoolConfig has store, key {
        id: 0x2::object::UID,
    }

    struct LendingPool has key {
        id: 0x2::object::UID,
        l: u16,
    }

    struct Position<phantom T0> {
        a: u64,
        m: u64,
    }

    struct PoolDeposit has copy, drop {
        a: u64,
    }

    struct PoolWithdraw has copy, drop {
        a: u64,
    }

    struct LoanComplete has copy, drop {
        a: u64,
        r: u64,
    }

    public fun aftermath_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun aftermath_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun aftermath_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun aftermath_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun alphafi_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun alphafi_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun bluefin_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun bluefin_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    fun borrow_impl<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = Position<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    public fun bucket_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun bucket_stake<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun bucket_unstake<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun bucket_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun cetus_add_liq<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun cetus_provide<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun cetus_remove<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun cetus_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun flowx_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun flowx_provide<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun flowx_remove<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun flowx_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun haedal_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun haedal_stake<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun haedal_unstake<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun haedal_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfig{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolConfig>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LendingPool{
            id : 0x2::object::new(arg0),
            l  : 100,
        };
        0x2::transfer::share_object<LendingPool>(v1);
    }

    public fun interest_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun interest_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun interest_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun interest_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun kai_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun kai_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun kai_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun kai_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun kriya_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun kriya_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun kriya_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun kriya_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun mole_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun mole_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun mole_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun mole_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun navi_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun navi_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun navi_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun navi_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public entry fun rebalance_pool<T0>(arg0: &mut LendingPool, arg1: &PoolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v1 = PoolWithdraw{a: arg2};
        0x2::event::emit<PoolWithdraw>(v1);
    }

    fun repay_impl<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        let Position {
            a : v0,
            m : v1,
        } = arg2;
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v1, 2);
        let v3 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v3)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, 0x2::coin::into_balance<T0>(arg1));
        };
        let v4 = LoanComplete{
            a : v0,
            r : v2,
        };
        0x2::event::emit<LoanComplete>(v4);
    }

    public fun scallop_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun scallop_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun scallop_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun scallop_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public entry fun set_utilization(arg0: &mut LendingPool, arg1: &PoolConfig, arg2: u16) {
        arg0.l = arg2;
    }

    public fun suilend_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun suilend_lend<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun suilend_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun suilend_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    fun tk<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    public fun turbos_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun turbos_redeem<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun turbos_supply<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun turbos_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public entry fun update_reserves<T0>(arg0: &mut LendingPool, arg1: &PoolConfig, arg2: 0x2::coin::Coin<T0>) {
        let v0 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg2));
        };
        let v1 = PoolDeposit{a: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<PoolDeposit>(v1);
    }

    public fun volo_deposit<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun volo_stake<T0>(arg0: &mut LendingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Position<T0>) {
        borrow_impl<T0>(arg0, arg1, arg2)
    }

    public fun volo_unstake<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    public fun volo_withdraw<T0>(arg0: &mut LendingPool, arg1: 0x2::coin::Coin<T0>, arg2: Position<T0>) {
        repay_impl<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

