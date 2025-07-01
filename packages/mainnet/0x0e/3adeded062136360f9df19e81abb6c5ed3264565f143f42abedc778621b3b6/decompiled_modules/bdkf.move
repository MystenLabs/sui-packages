module 0xe3adeded062136360f9df19e81abb6c5ed3264565f143f42abedc778621b3b6::bdkf {
    struct BDKF has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BDKF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BDKF>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BDKF>>(0x2::coin::mint<BDKF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BDKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDKF>(arg0, 6, b"BDKF", b"BDKF", b"BDKF Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BDKF>>(0x2::coin::mint<BDKF>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDKF>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BDKF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

