module 0xe4aebf85bf5a3f0d7034ac3083712c7c8e32a809ee5442bf5b148d8cd2886994::HOPA {
    struct HOPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPA>(arg0, 9, b"HOPA3", b"Brazil HOPA3", b"Brazil HOPA3 Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.investopedia.com/thmb/e2C53NxGwZAa0iyh-HpxK3r619I=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1258889149-1f50bb87f9d54dca87813923f12ac94b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

