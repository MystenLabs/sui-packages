module 0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::house {
    struct House<phantom T0> has key {
        id: 0x2::object::UID,
        fee_rate: u128,
        min_amount: u64,
        max_amount: u64,
        pool: 0x2::balance::Balance<T0>,
        treasury: 0x2::balance::Balance<T0>,
    }

    public fun new<T0>(arg0: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : House<T0> {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg0, arg1);
        assert!(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::constants::max_fee_rate() >= arg3, 9223372419106865153);
        House<T0>{
            id         : 0x2::object::new(arg6),
            fee_rate   : arg3,
            min_amount : arg4,
            max_amount : arg5,
            pool       : 0x2::coin::into_balance<T0>(arg2),
            treasury   : 0x2::balance::zero<T0>(),
        }
    }

    public fun add<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun destroy<T0>(arg0: House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin) {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg1, arg2);
        let House {
            id         : v0,
            fee_rate   : _,
            min_amount : _,
            max_amount : _,
            pool       : v4,
            treasury   : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v4;
        0x2::object::delete(v0);
        assert!(0x2::balance::value<T0>(&v7) == 0 && 0x2::balance::value<T0>(&v6) == 0, 9223372659625164803);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::balance::destroy_zero<T0>(v6);
    }

    public(friend) fun fee_rate<T0>(arg0: &House<T0>) : u128 {
        arg0.fee_rate
    }

    public(friend) fun max_amount<T0>(arg0: &House<T0>) : u64 {
        arg0.max_amount
    }

    public(friend) fun min_amount<T0>(arg0: &House<T0>) : u64 {
        arg0.min_amount
    }

    public(friend) fun pool_mut<T0>(arg0: &mut House<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.pool
    }

    public(friend) fun pool_value<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun pool_withdraw<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg3, 9223372719754838021);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg3), arg4)
    }

    public fun pool_withdraw_and_transfer<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(pool_withdraw<T0>(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public fun share<T0>(arg0: House<T0>) {
        0x2::transfer::share_object<House<T0>>(arg0);
    }

    public(friend) fun treasury_mut<T0>(arg0: &mut House<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.treasury
    }

    public fun treasury_withdraw<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg0.treasury) >= arg3, 9223372775589412869);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, arg3), arg4)
    }

    public fun treasury_withdraw_and_transfer<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(treasury_withdraw<T0>(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public fun update_fee<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u128) {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg1, arg2);
        assert!(0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::constants::max_fee_rate() >= arg3, 9223372500711243777);
        arg0.fee_rate = arg3;
    }

    public fun update_max_amount<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u64) {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg1, arg2);
        arg0.max_amount = arg3;
    }

    public fun update_min_amount<T0>(arg0: &mut House<T0>, arg1: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::AccessControl, arg2: &0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::access_control::Admin, arg3: u64) {
        0xa49baff28a6cff2553d5120cfacd965fc72e4efa652f3809471cb78489df232d::admin::assert_is_authorized(arg1, arg2);
        arg0.min_amount = arg3;
    }

    // decompiled from Move bytecode v6
}

