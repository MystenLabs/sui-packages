module 0x49ae8c025aea78750beb42f19ed6d15529f320eb323a272ecd527ca51a94fafb::dolpy {
    struct DOLPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPY>(arg0, 6, b"DOLPY", b"Sui Dolpy", b"Swimming with the waves in the vast ocean on the way to the paradise of Sui!  Embracing the thrill of the sea, every stroke brings us closer to a world of beauty and adventure. Let the ocean guide us to our sunny sanctuary! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_85_ba576a1757.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

