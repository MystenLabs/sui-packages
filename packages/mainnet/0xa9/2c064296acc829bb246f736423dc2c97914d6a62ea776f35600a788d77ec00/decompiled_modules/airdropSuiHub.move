module 0xa92c064296acc829bb246f736423dc2c97914d6a62ea776f35600a788d77ec00::airdropSuiHub {
    struct AirdropEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun send_by_allocation<T0: store>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = *0x1::vector::borrow<address>(&arg1, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v2, arg3), v3);
            let v4 = AirdropEvent{
                amount    : v2,
                recipient : v3,
            };
            0x2::event::emit<AirdropEvent>(v4);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

