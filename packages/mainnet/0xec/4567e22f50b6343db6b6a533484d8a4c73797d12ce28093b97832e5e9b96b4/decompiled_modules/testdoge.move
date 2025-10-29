module 0xec4567e22f50b6343db6b6a533484d8a4c73797d12ce28093b97832e5e9b96b4::testdoge {
    struct TESTDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTDOGE>, arg1: 0x2::coin::Coin<TESTDOGE>) {
        0x2::coin::burn<TESTDOGE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTDOGE>>(0x2::coin::mint<TESTDOGE>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<TESTDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTDOGE>>(0x2::coin::split<TESTDOGE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTDOGE>(arg0, 9, trim_right(b"DOGE"), trim_right(b"TESTDOGE"), trim_right(b"test coin"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreibssdrkgxh5yqhtznhc2k4toffuui5bgswwfdkwesong6wpp5eify"))), arg1);
        let v2 = v0;
        if (10000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTDOGE>>(0x2::coin::mint<TESTDOGE>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTDOGE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<TESTDOGE>, arg1: 0x2::coin::Coin<TESTDOGE>) {
        0x2::coin::join<TESTDOGE>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<TESTDOGE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTDOGE>>(0x2::coin::mint<TESTDOGE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

