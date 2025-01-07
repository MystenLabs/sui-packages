module 0x6e302bdc4f693d59ee9a5a4b4029acc61246c2a1d13c443585d1785de35910a2::flipper {
    struct FLIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPER>(arg0, 6, b"Flipper", b"Flipper on sui", b"There's a new meta in town \"flipper\", your friendly, intelligent dolphin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087417_128653c8c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

