module 0x56b67f3dd9fbaa23573bf5eff0dcd17c88b88e6b4d2024e3e29e4cc7a86eb4a0::batch_transfer {
    struct BatchTransferEvent has copy, drop {
        sender: address,
        token_type: vector<u8>,
        recipient_count: u64,
        total_amount: u64,
        service_fee: u64,
    }

    public fun batch_transfer<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 4);
        assert!(v0 <= 200, 1);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 150000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v2);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, *0x1::vector::borrow<u64>(&arg3, v2), arg4), *0x1::vector::borrow<address>(&arg2, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v3);
        let v4 = BatchTransferEvent{
            sender          : v3,
            token_type      : b"generic",
            recipient_count : v0,
            total_amount    : v1,
            service_fee     : 150000000,
        };
        0x2::event::emit<BatchTransferEvent>(v4);
    }

    public fun batch_transfer_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 4);
        assert!(v0 <= 200, 1);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 150000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v2);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, *0x1::vector::borrow<u64>(&arg3, v2), arg4), *0x1::vector::borrow<address>(&arg2, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v3);
        let v4 = BatchTransferEvent{
            sender          : v3,
            token_type      : b"SUI",
            recipient_count : v0,
            total_amount    : v1,
            service_fee     : 150000000,
        };
        0x2::event::emit<BatchTransferEvent>(v4);
    }

    public fun get_max_addresses() : u64 {
        200
    }

    public fun get_platform_address() : address {
        @0x3bc44c92f693a7e02ac587b6c221abe3084285f47c271e0d13b4d4599b22788
    }

    public fun get_service_fee() : u64 {
        150000000
    }

    // decompiled from Move bytecode v6
}

