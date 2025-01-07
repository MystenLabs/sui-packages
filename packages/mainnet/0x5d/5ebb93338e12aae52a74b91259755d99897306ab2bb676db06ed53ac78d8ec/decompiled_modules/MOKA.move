module 0x5d5ebb93338e12aae52a74b91259755d99897306ab2bb676db06ed53ac78d8ec::MOKA {
    struct MOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKA>(arg0, 9, b"MAMA", b"Lala MAMA 11", b"Lala MAMA 11 Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.investopedia.com/thmb/e2C53NxGwZAa0iyh-HpxK3r619I=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1258889149-1f50bb87f9d54dca87813923f12ac94b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOKA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

