module 0x66a28ae668e09c3b932ccfb25332005e2116b83b28c3442798ff02d526bc5fdb::treasury {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
    }

    struct CollectFeeEvent<phantom T0> has copy, drop {
        memo: 0x1::ascii::String,
        amount: u64,
    }

    struct DustEvent<phantom T0> has copy, drop {
        memo: 0x1::ascii::String,
        amount: u64,
    }

    public fun admin_withdraw<T0>(arg0: &AdminCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.funds), 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.funds, arg2), arg3)
    }

    public fun balance_of<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun collect_dust_balance<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::ascii::String) {
        emit_dust<T0>(arg2, 0x2::balance::value<T0>(&arg1));
        0x2::balance::join<T0>(&mut arg0.funds, arg1);
    }

    public fun collect_dust_coin<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String) {
        emit_dust<T0>(arg2, 0x2::coin::value<T0>(&arg1));
        0x2::coin::put<T0>(&mut arg0.funds, arg1);
    }

    public fun collect_fee_balance<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::balance::split<T0>(arg1, 0x66a28ae668e09c3b932ccfb25332005e2116b83b28c3442798ff02d526bc5fdb::math::mul_factor(0x2::balance::value<T0>(arg1), arg2, 1000000));
        emit_collect_fee<T0>(arg3, 0x2::balance::value<T0>(&v0));
        0x2::balance::join<T0>(&mut arg0.funds, v0);
    }

    public fun collect_fee_coin<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T0>(arg1, 0x66a28ae668e09c3b932ccfb25332005e2116b83b28c3442798ff02d526bc5fdb::math::mul_factor(0x2::coin::value<T0>(arg1), arg2, 1000000), arg4);
        emit_collect_fee<T0>(arg3, 0x2::coin::value<T0>(&v0));
        0x2::coin::put<T0>(&mut arg0.funds, v0);
    }

    public fun create_treasury<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id    : 0x2::object::new(arg1),
            funds : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    fun emit_collect_fee<T0>(arg0: 0x1::ascii::String, arg1: u64) {
        let v0 = CollectFeeEvent<T0>{
            memo   : arg0,
            amount : arg1,
        };
        0x2::event::emit<CollectFeeEvent<T0>>(v0);
    }

    fun emit_dust<T0>(arg0: 0x1::ascii::String, arg1: u64) {
        let v0 = DustEvent<T0>{
            memo   : arg0,
            amount : arg1,
        };
        0x2::event::emit<DustEvent<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

