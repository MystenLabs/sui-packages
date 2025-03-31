module 0x3b385572ee407a8377eb5c250c6c4ea7e99b38ec074ffccd057f9198ea7086c9::wdust {
    struct WDUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDUST>(arg0, 6, b"WDUST", b"Walrus Dust", b"The first Sui Walrus Dust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waldust_10ec079526.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

