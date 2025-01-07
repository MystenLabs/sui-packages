module 0x4b3f4ebb8c6ca3c9f8469d8469a25e788fd4b79002c6f559da8d4e40b486689d::ts {
    struct TS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TS>(arg0, 6, b"TS", b"SUI TS", b"Today TS finally met everyone at SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ff7294adb58761d2_4ec329b77a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TS>>(v1);
    }

    // decompiled from Move bytecode v6
}

