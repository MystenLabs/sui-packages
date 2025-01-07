module 0xef969094745272745ebdab7dc8d2c1c0468e2ffcafd57b5348c3464e12acfcbf::sucat {
    struct SUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCAT>(arg0, 6, b"SUCAT", b"SuimonsCat", b"ONE CAT, BILLIONS OF OWNERS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_png_9d5b12e4b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

