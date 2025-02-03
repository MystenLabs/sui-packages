module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::rebate {
    struct Rebate<phantom T0> has store {
        funds: 0x2::balance::Balance<T0>,
        rebate_amount: u64,
    }

    struct RebateDfKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    public fun apply_rebate<T0: store + key, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::balance::Balance<T1>) {
        if (has_rebate<T0, T1>(arg0)) {
            let v0 = borrow_rebate_mut<T0, T1>(arg0);
            if (0x2::balance::value<T1>(&v0.funds) >= v0.rebate_amount) {
                0x2::balance::join<T1>(arg1, 0x2::balance::split<T1>(&mut v0.funds, v0.rebate_amount));
            };
        };
    }

    public fun borrow_rebate<T0: store + key, T1>(arg0: &0x2::object::UID) : &Rebate<T1> {
        assert!(has_rebate<T0, T1>(arg0), 1);
        let v0 = RebateDfKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RebateDfKey<T0, T1>, Rebate<T1>>(arg0, v0)
    }

    public fun borrow_rebate_amount<T0>(arg0: &Rebate<T0>) : u64 {
        arg0.rebate_amount
    }

    public fun borrow_rebate_funds<T0>(arg0: &Rebate<T0>) : &0x2::balance::Balance<T0> {
        &arg0.funds
    }

    public fun borrow_rebate_mut<T0: store + key, T1>(arg0: &mut 0x2::object::UID) : &mut Rebate<T1> {
        assert!(has_rebate<T0, T1>(arg0), 1);
        let v0 = RebateDfKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RebateDfKey<T0, T1>, Rebate<T1>>(arg0, v0)
    }

    public fun fund_rebate<T0: store + key, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64) {
        0x2::balance::join<T1>(&mut borrow_rebate_mut<T0, T1>(arg0).funds, 0x2::balance::split<T1>(arg1, arg2));
    }

    public fun has_rebate<T0: store + key, T1>(arg0: &0x2::object::UID) : bool {
        let v0 = RebateDfKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RebateDfKey<T0, T1>, Rebate<T1>>(arg0, v0)
    }

    public fun send_rebate<T0: store + key, T1>(arg0: &mut 0x2::object::UID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T1>();
        let v1 = &mut v0;
        apply_rebate<T0, T1>(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg2), arg1);
    }

    public fun set_rebate<T0: store + key, T1>(arg0: &mut 0x2::object::UID, arg1: u64) {
        if (has_rebate<T0, T1>(arg0)) {
            borrow_rebate_mut<T0, T1>(arg0).rebate_amount = arg1;
        } else {
            let v0 = Rebate<T1>{
                funds         : 0x2::balance::zero<T1>(),
                rebate_amount : arg1,
            };
            let v1 = RebateDfKey<T0, T1>{dummy_field: false};
            0x2::dynamic_field::add<RebateDfKey<T0, T1>, Rebate<T1>>(arg0, v1, v0);
        };
    }

    public fun withdraw_rebate_funds<T0: store + key, T1>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::balance::Balance<T1>, arg2: u64) {
        0x2::balance::join<T1>(arg1, 0x2::balance::split<T1>(&mut borrow_rebate_mut<T0, T1>(arg0).funds, arg2));
    }

    // decompiled from Move bytecode v6
}

