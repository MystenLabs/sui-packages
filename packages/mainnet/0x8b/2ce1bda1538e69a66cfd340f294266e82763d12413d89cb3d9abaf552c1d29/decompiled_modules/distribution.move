module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::distribution {
    struct Distributed has copy, drop {
        sender: address,
        recipients: u64,
        amount: u64,
    }

    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = if (v0 > 0) {
            if (v0 <= 200) {
                v0 == 0x1::vector::length<u64>(&arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<address>(&arg1, v3) != @0x0 && *0x1::vector::borrow<u64>(&arg2, v3) > 0, 2);
            v2 = v2 + (*0x1::vector::borrow<u64>(&arg2, v3) as u128);
            v3 = v3 + 1;
        };
        assert!(v2 <= (0x2::coin::value<T0>(&arg0) as u128), 3);
        v3 = 0;
        while (v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v3), arg3), *0x1::vector::borrow<address>(&arg1, v3));
            v3 = v3 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        };
        let v4 = Distributed{
            sender     : 0x2::tx_context::sender(arg3),
            recipients : v0,
            amount     : (v2 as u64),
        };
        0x2::event::emit<Distributed>(v4);
    }

    // decompiled from Move bytecode v7
}

