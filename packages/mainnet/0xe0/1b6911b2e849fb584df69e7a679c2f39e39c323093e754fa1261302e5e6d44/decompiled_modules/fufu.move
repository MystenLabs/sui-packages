module 0xe01b6911b2e849fb584df69e7a679c2f39e39c323093e754fa1261302e5e6d44::fufu {
    struct FUFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFU>(arg0, 6, b"FUFU", b"fufu", b"you must HODL to be rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fufu_001_470dc52900.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

