module 0x8ab6d704cfbceb3313125bd8d470b67b647b6533c6dd8f290307ecd1b48dd1c1::wdr {
    struct WithdrawRequest<phantom T0, phantom T1> {
        coin_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        witness: 0x1::type_name::TypeName,
    }

    public(friend) fun consume<T0, T1>(arg0: WithdrawRequest<T0, T1>) : (0x2::balance::Balance<T0>, 0x1::type_name::TypeName) {
        let WithdrawRequest {
            coin_amount : v0,
            balance     : v1,
            witness     : v2,
        } = arg0;
        let v3 = v1;
        assert!(v0 - 0x2::balance::value<T0>(&v3) <= v0 / 100000 + 100, 10);
        (v3, v2)
    }

    public(friend) fun fill<T0, T1, T2: drop>(arg0: &mut WithdrawRequest<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: T2) {
        assert!(arg0.witness == 0x1::type_name::with_defining_ids<T2>(), 9);
        assert!(0x2::balance::value<T0>(&arg0.balance) + 0x2::balance::value<T0>(&arg1) <= arg0.coin_amount, 10);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun get_coin_amount<T0, T1>(arg0: &WithdrawRequest<T0, T1>) : u64 {
        arg0.coin_amount
    }

    public fun get_witness<T0, T1>(arg0: &WithdrawRequest<T0, T1>) : 0x1::type_name::TypeName {
        arg0.witness
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: 0x1::type_name::TypeName) : WithdrawRequest<T0, T1> {
        WithdrawRequest<T0, T1>{
            coin_amount : arg0,
            balance     : 0x2::balance::zero<T0>(),
            witness     : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

