module 0x5bd1520708671f1c4931dc127bfd45cecd67ae231cb42fa9062b27fc4f91b1ab::batch_transfer {
    struct BatchTransferEvent has copy, drop {
        sender: address,
        recipients: vector<address>,
        amounts: vector<u64>,
        timestamp: u64,
    }

    public entry fun transfer_custom(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0, 1);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, *0x1::vector::borrow<u64>(&arg2, v3), arg3), *0x1::vector::borrow<address>(&arg1, v3));
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

    public entry fun transfer_equal(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg2 * 0x1::vector::length<address>(&arg1), 2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<u64>(&mut v0, arg2);
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v2));
            v2 = v2 + 1;
        };
        let v3 = BatchTransferEvent{
            sender     : 0x2::tx_context::sender(arg3),
            recipients : arg1,
            amounts    : v0,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BatchTransferEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

