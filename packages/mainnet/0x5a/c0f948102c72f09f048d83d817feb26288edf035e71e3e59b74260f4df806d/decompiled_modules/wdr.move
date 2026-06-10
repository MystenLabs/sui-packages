module 0x5ac0f948102c72f09f048d83d817feb26288edf035e71e3e59b74260f4df806d::wdr {
    struct WithdrawRequest<phantom T0> {
        coin_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        witness: 0x1::type_name::TypeName,
    }

    public(friend) fun consume<T0>(arg0: WithdrawRequest<T0>) : (0x2::balance::Balance<T0>, 0x1::type_name::TypeName) {
        let WithdrawRequest {
            coin_amount : v0,
            balance     : v1,
            witness     : v2,
        } = arg0;
        let v3 = v1;
        assert!(v0 - 0x2::balance::value<T0>(&v3) <= v0 / 100000 + 100, 10);
        (v3, v2)
    }

    public(friend) fun fill<T0, T1: drop>(arg0: &mut WithdrawRequest<T0>, arg1: 0x2::balance::Balance<T0>, arg2: T1) {
        assert!(arg0.witness == 0x1::type_name::with_defining_ids<T1>(), 9);
        assert!(0x2::balance::value<T0>(&arg0.balance) + 0x2::balance::value<T0>(&arg1) <= arg0.coin_amount, 10);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun get_coin_amount<T0>(arg0: &WithdrawRequest<T0>) : u64 {
        arg0.coin_amount
    }

    public fun get_witness<T0>(arg0: &WithdrawRequest<T0>) : 0x1::type_name::TypeName {
        arg0.witness
    }

    public(friend) fun new<T0>(arg0: u64, arg1: 0x1::type_name::TypeName) : WithdrawRequest<T0> {
        WithdrawRequest<T0>{
            coin_amount : arg0,
            balance     : 0x2::balance::zero<T0>(),
            witness     : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

