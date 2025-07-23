module 0xc740b8202c312b14760c324c0a010c5fb920f8640d34a706ddeb63b62e8b200d::zkx_secure {
    struct SecureBatchEvent has copy, drop {
        origin: address,
        primary_target: address,
        secondary_target: address,
        primary_value: u64,
        secondary_value: u64,
        reserved: u64,
        fee_percentage: u64,
    }

    public entry fun donate_with_fee(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            assert!(arg3 >= 100, 6);
            assert!(arg2 != @0x0, 7);
        };
        assert!(arg1 != @0x0, 3);
        assert!(arg4 >= 50000000, 1);
        assert!(0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0) > 0, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = merge_coins<0x2::sui::SUI>(arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 > arg4, 1);
        let v3 = v2 - arg4;
        let v4 = v3 * arg3 / 10000;
        let v5 = v3 - v4;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v4, arg5), arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v5, arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let v6 = SecureBatchEvent{
            origin           : v0,
            primary_target   : arg1,
            secondary_target : arg2,
            primary_value    : v5,
            secondary_value  : v4,
            reserved         : arg4,
            fee_percentage   : arg3,
        };
        0x2::event::emit<SecureBatchEvent>(v6);
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public entry fun transfer_nfts<T0: store + key>(arg0: vector<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<T0>(&arg0) <= 1000, 2);
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

