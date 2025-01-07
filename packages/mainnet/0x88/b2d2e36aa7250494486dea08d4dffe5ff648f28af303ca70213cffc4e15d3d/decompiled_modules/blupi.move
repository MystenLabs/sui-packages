module 0x88b2d2e36aa7250494486dea08d4dffe5ff648f28af303ca70213cffc4e15d3d::blupi {
    struct BLUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPI>(arg0, 6, b"BLUPI", b"Blupigeon", x"4669727374206d656d6520706967656f6e206f6e205355490a50524553414c45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039196_52c6660140.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

