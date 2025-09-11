module 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::pool_manager {
    struct PoolManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_balance_amount: u64,
        balance: 0x2::bag::Bag,
        manage_type: u8,
        active_coin_type: 0x1::ascii::String,
        active_coin_amount: u64,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct PoolCreate has copy, drop {
        creator: address,
    }

    struct PoolBalanceRegister has copy, drop {
        sender: address,
        amount: u64,
        new_amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolDeposit has copy, drop {
        sender: address,
        amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolWithdraw has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolWitdrawReserve has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        before: u64,
        after: u64,
        pool: 0x1::ascii::String,
        poolId: address,
    }

    public fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : PoolManager<T0> {
        PoolManager<T0>{
            id                  : 0x2::object::new(arg1),
            pool_balance_amount : arg0,
            balance             : 0x2::bag::new(arg1),
            manage_type         : 0,
            active_coin_type    : 0x1::ascii::string(b""),
            active_coin_amount  : 0,
        }
    }

    public(friend) fun prepare_before_withdraw<T0>(arg0: &mut PoolManager<T0>, arg1: u64) {
        if (arg0.manage_type == 0) {
            return
        };
        if (arg0.manage_type == 1) {
            prepare_before_withdraw_sui<T0>(arg0, arg1);
        };
    }

    public fun prepare_before_withdraw_sui<T0>(arg0: &PoolManager<T0>, arg1: u64) : u64 {
        arg0.pool_balance_amount
    }

    public(friend) fun refresh_after_deposit<T0>(arg0: &mut PoolManager<T0>, arg1: &mut 0x2::balance::Balance<T0>) {
        if (arg0.manage_type == 0) {
            return
        };
        if (arg0.manage_type == 1) {
            refresh_after_deposit_sui<T0>(arg0, arg1);
        };
    }

    public fun refresh_after_deposit_sui<T0>(arg0: &mut PoolManager<T0>, arg1: &mut 0x2::balance::Balance<T0>) : u64 {
        arg0.pool_balance_amount
    }

    public(friend) fun set_manage_type<T0>(arg0: &mut PoolManager<T0>, arg1: u8) {
        assert!(arg0.active_coin_amount == 0, 0);
        if (arg1 == 0) {
        } else {
            assert!(arg1 == 1, 0);
            let v0 = 0x1::type_name::get_with_original_ids<0x2::sui::SUI>();
            let v1 = 0x1::type_name::get_with_original_ids<0x2::sui::SUI>();
            let v2 = 0x1::type_name::as_string(&v1);
            let v3 = 0x1::type_name::get_with_original_ids<T0>();
            assert!(0x1::type_name::as_string(&v3) == 0x1::type_name::as_string(&v0), 0);
            arg0.active_coin_type = *v2;
        };
        arg0.manage_type = arg1;
    }

    // decompiled from Move bytecode v6
}

