module 0xf70150c5d5eade86225945ff52053f0138444a6060a2a6384d13bbfbd8232d65::multisend {
    struct CustomObject has store, key {
        id: 0x2::object::UID,
        balance: u64,
    }

    public fun create_and_transfer_object(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CustomObject{
            id      : 0x2::object::new(arg2),
            balance : arg1,
        };
        0x2::transfer::transfer<CustomObject>(v0, arg0);
    }

    public fun send_multiple_coins(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) > 0, 0);
        assert!(0x1::vector::length<u64>(&arg2) > 0, 1);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun send_sui_to_one_address(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) > 0, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), arg1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

