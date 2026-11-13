module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate {
    struct RebateVault has key {
        id: 0x2::object::UID,
        coin: 0x1::ascii::String,
        funds: u64,
        ref_value: u64,
        rebate_bps: u64,
        funded_total: u64,
        paid_total: u64,
        short_total: u64,
    }

    struct FundsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RebatePaid has copy, drop {
        minter: address,
        count: u64,
        amount: u64,
        short: u64,
    }

    struct RebateFunded has copy, drop {
        amount: u64,
        from: address,
    }

    public fun balance(arg0: &RebateVault) : u64 {
        arg0.funds
    }

    public fun coin(arg0: &RebateVault) : 0x1::ascii::String {
        arg0.coin
    }

    public fun coin_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public(friend) fun create<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : RebateVault {
        create_named(coin_name<T0>(), arg0, arg1, arg2)
    }

    public(friend) fun create_named(arg0: 0x1::ascii::String, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RebateVault {
        assert!(arg2 <= 2000, 1);
        RebateVault{
            id           : 0x2::object::new(arg3),
            coin         : arg0,
            funds        : 0,
            ref_value    : arg1,
            rebate_bps   : arg2,
            funded_total : 0,
            paid_total   : 0,
            short_total  : 0,
        }
    }

    public fun fund<T0>(arg0: &mut RebateVault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = funds_mut<T0>(arg0);
        0x2::balance::join<T0>(v1, 0x2::coin::into_balance<T0>(arg1));
        arg0.funds = arg0.funds + v0;
        arg0.funded_total = arg0.funded_total + v0;
        let v2 = RebateFunded{
            amount : v0,
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RebateFunded>(v2);
    }

    fun funds_mut<T0>(arg0: &mut RebateVault) : &mut 0x2::balance::Balance<T0> {
        assert!(arg0.coin == coin_name<T0>(), 2);
        let v0 = FundsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FundsKey>(&arg0.id, v0)) {
            let v1 = FundsKey{dummy_field: false};
            0x2::dynamic_field::add<FundsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = FundsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FundsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2)
    }

    public fun paid_total(arg0: &RebateVault) : u64 {
        arg0.paid_total
    }

    public(friend) fun pay<T0>(arg0: &mut RebateVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = per_spice(arg0) * arg1;
        pay_exact<T0>(arg0, v0, arg1, arg2)
    }

    public(friend) fun pay_exact<T0>(arg0: &mut RebateVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.funds;
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        let v2 = arg1 - v1;
        arg0.paid_total = arg0.paid_total + v1;
        arg0.short_total = arg0.short_total + v2;
        if (v1 > 0) {
            let v3 = funds_mut<T0>(arg0);
            arg0.funds = arg0.funds - v1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, v1), arg3), 0x2::tx_context::sender(arg3));
        } else {
            assert!(arg0.coin == coin_name<T0>(), 2);
        };
        let v4 = RebatePaid{
            minter : 0x2::tx_context::sender(arg3),
            count  : arg2,
            amount : v1,
            short  : v2,
        };
        0x2::event::emit<RebatePaid>(v4);
        v1
    }

    public fun per_spice(arg0: &RebateVault) : u64 {
        (((arg0.ref_value as u128) * (arg0.rebate_bps as u128) / 10000) as u64)
    }

    public fun rebate_bps(arg0: &RebateVault) : u64 {
        arg0.rebate_bps
    }

    public fun ref_value(arg0: &RebateVault) : u64 {
        arg0.ref_value
    }

    public(friend) fun set_params(arg0: &mut RebateVault, arg1: u64, arg2: u64) {
        assert!(arg2 <= 2000, 1);
        arg0.ref_value = arg1;
        arg0.rebate_bps = arg2;
    }

    public(friend) fun share(arg0: RebateVault) {
        0x2::transfer::share_object<RebateVault>(arg0);
    }

    public(friend) fun withdraw<T0>(arg0: &mut RebateVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = funds_mut<T0>(arg0);
        arg0.funds = arg0.funds - arg1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

