module 0xc3c19825833b096ba2d7d6fce2ef9eac93965edd7b33cd244cc450607b2d8658::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIMON>, arg1: 0x2::coin::Coin<SUIMON>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUIMON>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIMON>>(0x2::coin::mint<SUIMON>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SUIMON>(arg0, 9, b"SUIMON", b"SUIMON", x"5355494d4f4e20e2809420746865206c6567656e6461727920537569206d6f6e73746572206d656d6520636f696e2e2043617463682027656d20616c6c206f6e2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/suimon.jpg/200x200")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUIMON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUIMON>>(v0);
    }

    // decompiled from Move bytecode v6
}

