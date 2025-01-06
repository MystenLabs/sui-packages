module 0xed6c93ef19d191e1cc856914d329c4a9316aebbba7be6e363ad728d8d1376570::detf {
    struct DETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DETF>(arg0, 9, b"DETF", b"Decentralized ETF", b"All-in-one trading platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.d-etf.com/detf_maskable_icon_x512.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DETF>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DETF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DETF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

