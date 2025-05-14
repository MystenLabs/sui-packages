module 0xe9ceb4198fa02d4d230c945934f72286ee31dbdfd235f32c259115aa467ac457::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 6, b"EEVEE", b"Eevee SUI", b"Memes evolve. So do we", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaj2h7jttfigj7srdip6qrrulq5hn5qmwstebnzqhyehjrilgjgp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

