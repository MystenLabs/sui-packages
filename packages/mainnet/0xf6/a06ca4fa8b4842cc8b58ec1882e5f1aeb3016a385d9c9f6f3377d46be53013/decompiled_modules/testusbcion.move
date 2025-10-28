module 0xf6a06ca4fa8b4842cc8b58ec1882e5f1aeb3016a385d9c9f6f3377d46be53013::testusbcion {
    struct TESTUSBCION has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTUSBCION>, arg1: 0x2::coin::Coin<TESTUSBCION>) {
        0x2::coin::burn<TESTUSBCION>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTUSBCION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSBCION>>(0x2::coin::mint<TESTUSBCION>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<TESTUSBCION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSBCION>>(0x2::coin::split<TESTUSBCION>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTUSBCION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTUSBCION>(arg0, 9, trim_right(b"USDC"), trim_right(b"testusbcion"), trim_right(b"yulezhuanyong"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreicrbhwfehj2o2t6a6tho5rdypqpdw2dn4aa3lmc27t36iicn2oxq4"))), arg1);
        let v2 = v0;
        if (75905666000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSBCION>>(0x2::coin::mint<TESTUSBCION>(&mut v2, 75905666000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTUSBCION>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTUSBCION>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<TESTUSBCION>, arg1: 0x2::coin::Coin<TESTUSBCION>) {
        0x2::coin::join<TESTUSBCION>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<TESTUSBCION>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTUSBCION>>(0x2::coin::mint<TESTUSBCION>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

