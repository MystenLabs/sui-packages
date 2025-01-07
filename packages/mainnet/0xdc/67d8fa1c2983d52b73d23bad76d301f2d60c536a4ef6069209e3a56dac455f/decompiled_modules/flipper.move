module 0xdc67d8fa1c2983d52b73d23bad76d301f2d60c536a4ef6069209e3a56dac455f::flipper {
    struct FLIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPER>(arg0, 6, b"Flipper", b"Flipper on sui", b"There's a new meta in town \"flipper\", your friendly, intelligent dolphin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087417_78dc18c9ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

