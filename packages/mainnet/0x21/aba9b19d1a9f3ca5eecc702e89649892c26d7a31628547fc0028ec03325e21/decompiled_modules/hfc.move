module 0x21aba9b19d1a9f3ca5eecc702e89649892c26d7a31628547fc0028ec03325e21::hfc {
    struct HFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFC>(arg0, 9, b"HFC", b"Hind Future", b"Social work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HFC>(&mut v2, 100000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

