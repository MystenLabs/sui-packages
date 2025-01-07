module 0x1c308b5b6ab937d9e4ca02851837bc1f2fc126afe46dc3b7cabd77303392f93a::towel {
    struct TOWEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWEL>(arg0, 6, b"TOWEL", b"sadasd", b"sdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_17_cef4ac4771.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

