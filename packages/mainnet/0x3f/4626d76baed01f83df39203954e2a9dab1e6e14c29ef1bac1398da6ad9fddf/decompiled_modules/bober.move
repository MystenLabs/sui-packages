module 0x3f4626d76baed01f83df39203954e2a9dab1e6e14c29ef1bac1398da6ad9fddf::bober {
    struct BOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBER>(arg0, 6, b"BOBER", b"Capibara", b"a cute capibara chilling on the side of the sui pond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ca5f22883d5f11cffceb2b76c94491ff_ef38c7d44a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

