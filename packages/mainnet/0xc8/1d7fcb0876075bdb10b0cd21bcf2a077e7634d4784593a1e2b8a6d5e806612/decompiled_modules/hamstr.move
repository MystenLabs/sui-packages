module 0xc81d7fcb0876075bdb10b0cd21bcf2a077e7634d4784593a1e2b8a6d5e806612::hamstr {
    struct HAMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTR>(arg0, 6, b"HAMSTR", b"HAMSTER", b"soon there will be a listing of the hamster coin, so I decided to create a meme for fun...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lysaia_krysa_dambo_7_738f565c23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

