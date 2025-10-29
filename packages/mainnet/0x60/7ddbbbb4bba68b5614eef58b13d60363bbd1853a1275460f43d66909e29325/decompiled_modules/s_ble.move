module 0x607ddbbbb4bba68b5614eef58b13d60363bbd1853a1275460f43d66909e29325::s_ble {
    struct S_BLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<S_BLE>, arg1: 0x2::coin::Coin<S_BLE>) {
        0x2::coin::burn<S_BLE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<S_BLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<S_BLE>>(0x2::coin::mint<S_BLE>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<S_BLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<S_BLE>>(0x2::coin::split<S_BLE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: S_BLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S_BLE>(arg0, 9, trim_right(b"BLE"), trim_right(b"S BLE"), trim_right(b"haapuzhuanyong"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreifryip4aleycy6bktbgl7u7fusppwkwz2rum2mo2g5quhfck25iyu"))), arg1);
        let v2 = v0;
        if (3698686000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<S_BLE>>(0x2::coin::mint<S_BLE>(&mut v2, 3698686000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S_BLE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<S_BLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<S_BLE>, arg1: 0x2::coin::Coin<S_BLE>) {
        0x2::coin::join<S_BLE>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<S_BLE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<S_BLE>>(0x2::coin::mint<S_BLE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (*0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != 32) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

