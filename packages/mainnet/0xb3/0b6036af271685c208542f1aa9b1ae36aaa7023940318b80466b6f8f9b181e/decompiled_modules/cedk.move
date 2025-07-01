module 0xb30b6036af271685c208542f1aa9b1ae36aaa7023940318b80466b6f8f9b181e::cedk {
    struct CEDK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CEDK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<CEDK>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CEDK>>(0x2::coin::mint<CEDK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CEDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEDK>(arg0, 6, b"CEDK", b"CEDK", b"CEDK Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CEDK>>(0x2::coin::mint<CEDK>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEDK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CEDK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

