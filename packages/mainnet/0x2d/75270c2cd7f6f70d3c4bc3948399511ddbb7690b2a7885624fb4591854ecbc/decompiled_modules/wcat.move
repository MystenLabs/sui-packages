module 0x2d75270c2cd7f6f70d3c4bc3948399511ddbb7690b2a7885624fb4591854ecbc::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 6, b"WCAT", b"WET CAT", b"THE CAT LIKES IT WET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_11_5a640ee147.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

