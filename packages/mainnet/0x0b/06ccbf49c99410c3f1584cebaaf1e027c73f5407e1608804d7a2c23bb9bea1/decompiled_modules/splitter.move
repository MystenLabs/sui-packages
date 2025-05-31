module 0xb06ccbf49c99410c3f1584cebaaf1e027c73f5407e1608804d7a2c23bb9bea1::splitter {
    struct Splitter has store, key {
        id: 0x2::object::UID,
        initialized: bool,
    }

    struct EqualSplitEvent has copy, drop {
        amount: u64,
        recipient_count: u64,
        amount_per_recipient: u64,
    }

    struct AirdropEvent has copy, drop {
        total_amount: u64,
        recipient_count: u64,
    }

    public entry fun airdrop_funds<T0>(arg0: &Splitter, arg1: 0x2::coin::Coin<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized, 0);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == v1, 2);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg1) >= v2, 3);
        let v4 = AirdropEvent{
            total_amount    : v2,
            recipient_count : v0,
        };
        0x2::event::emit<AirdropEvent>(v4);
        let v5 = 0;
        while (v5 < v0) {
            let v6 = *0x1::vector::borrow<u64>(&arg3, v5);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v6, arg4), *0x1::vector::borrow<address>(&arg2, v5));
            };
            v5 = v5 + 1;
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Splitter{
            id          : 0x2::object::new(arg0),
            initialized : true,
        };
        0x2::transfer::share_object<Splitter>(v0);
    }

    public entry fun split_funds_equal<T0>(arg0: &Splitter, arg1: 0x2::coin::Coin<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized, 0);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= 100000000, 4);
        let v2 = v1 / (v0 as u64);
        assert!(v2 > 0, 3);
        let v3 = EqualSplitEvent{
            amount               : v1,
            recipient_count      : v0,
            amount_per_recipient : v2,
        };
        0x2::event::emit<EqualSplitEvent>(v3);
        let v4 = 0;
        while (v4 < v0 - 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg3), *0x1::vector::borrow<address>(&arg2, v4));
            v4 = v4 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, *0x1::vector::borrow<address>(&arg2, v0 - 1));
    }

    // decompiled from Move bytecode v6
}

