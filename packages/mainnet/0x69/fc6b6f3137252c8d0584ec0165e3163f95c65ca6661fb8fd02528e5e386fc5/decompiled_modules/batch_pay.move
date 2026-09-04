module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::batch_pay {
    struct BatchDisbursed has copy, drop {
        batch_id: vector<u8>,
        count: u64,
        total: u64,
        payer: address,
    }

    public fun pay_many<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::ComplianceRegistry, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 760);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 761);
        0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::assert_clear(arg1, 0x2::tx_context::sender(arg5));
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = 0;
        let v3 = &arg3;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(v3)) {
            let v5 = 0x1::vector::borrow<u64>(v3, v4);
            assert!(*v5 > 0, 763);
            v2 = v2 + *v5;
            v4 = v4 + 1;
        };
        assert!(v2 == v1, 762);
        let v6 = 0x2::coin::into_balance<T0>(arg0);
        let v7 = 0;
        while (v7 < v0) {
            let v8 = *0x1::vector::borrow<address>(&arg2, v7);
            assert!(v8 != @0x0, 764);
            0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance::assert_clear(arg1, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, *0x1::vector::borrow<u64>(&arg3, v7)), arg5), v8);
            v7 = v7 + 1;
        };
        0x2::balance::destroy_zero<T0>(v6);
        let v9 = BatchDisbursed{
            batch_id : arg4,
            count    : v0,
            total    : v1,
            payer    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<BatchDisbursed>(v9);
    }

    // decompiled from Move bytecode v7
}

