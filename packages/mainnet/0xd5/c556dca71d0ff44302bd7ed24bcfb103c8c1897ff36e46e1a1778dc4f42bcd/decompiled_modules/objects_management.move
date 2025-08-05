module 0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::objects_management {
    public fun receive_batch_and_transfer<T0>(arg0: &mut 0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::SmartWallet, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: vector<u64>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::is_executor(arg0, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == v1 && v1 == 0x1::vector::length<address>(&arg3), 3);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            let v4 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::get_wallet_uid_mut(arg0), 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1));
            let v5 = 0x2::coin::value<T0>(&v4);
            if (v3 == 0 || v3 == v5) {
                if (v3 == 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::object::id_address<0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::SmartWallet>(arg0));
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, *0x1::vector::borrow<address>(&arg3, v2));
                };
            } else {
                assert!(v5 >= v3, 2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v3, arg4), *0x1::vector::borrow<address>(&arg3, v2));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::object::id_address<0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::SmartWallet>(arg0));
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
    }

    public entry fun receive_single_and_transfer<T0>(arg0: &mut 0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::SmartWallet, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::is_executor(arg0, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::get_wallet_uid_mut(arg0), arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (arg2 == 0 || arg2 == v1) {
            if (arg2 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::id_address<0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::SmartWallet>(arg0));
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            };
        } else {
            assert!(v1 >= arg2, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg2, arg4), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::id_address<0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet::SmartWallet>(arg0));
        };
    }

    // decompiled from Move bytecode v6
}

