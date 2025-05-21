module 0x5e6e732707b590884d494bc847cf1d72e159541a29ef85d6f3f5860a4ce4548f::batch_transfer {
    struct BatchTransferEvent has copy, drop {
        sender: address,
        recipients: vector<address>,
        amounts: vector<u64>,
        timestamp: u64,
    }

    public entry fun transfer_custom<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0, 1);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<T0>(arg0) >= v0, 2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, *0x1::vector::borrow<u64>(&arg2, v3), arg3), *0x1::vector::borrow<address>(&arg1, v3));
            v3 = v3 + 1;
        };
        let v4 = BatchTransferEvent{
            sender     : 0x2::tx_context::sender(arg3),
            recipients : arg1,
            amounts    : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BatchTransferEvent>(v4);
    }

    public entry fun transfer_equal<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T0>(arg0) >= arg2 * 0x1::vector::length<address>(&arg1), 2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<u64>(&mut v0, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = BatchTransferEvent{
            sender     : 0x2::tx_context::sender(arg3),
            recipients : arg1,
            amounts    : v0,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BatchTransferEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

