module 0xf7449f304d61ecdae8a980cb5614746c151a18d4b7deeef5495a4415374466fc::smario {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARIO>(arg0, 6, b"SMARIO", b"Suiper Mario", b"Meme inspired by the classic game Super Mario Bros...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024609_6994f0fb9d_6ab7e5c120.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

