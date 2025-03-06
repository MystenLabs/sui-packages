module 0x10ea214a26087f4e0a13777e4b3eb2669678388163b5cf639fed70923438d28d::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"World Liberty Financial Integrates", b"WLFI will include SUI in their strategic token reserve designed to bolster leading Web3 projects", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cached_Image_4318503b02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

