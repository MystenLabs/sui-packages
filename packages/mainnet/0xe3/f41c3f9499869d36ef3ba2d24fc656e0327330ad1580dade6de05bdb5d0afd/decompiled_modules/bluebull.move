module 0xe3f41c3f9499869d36ef3ba2d24fc656e0327330ad1580dade6de05bdb5d0afd::bluebull {
    struct BLUEBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBULL>(arg0, 6, b"BlueBull", b"Blue Bull", b"BLUEBULL Sui bullish on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_00_00_05_7590cba498.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

