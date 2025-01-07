module 0xdd24399e4e35951da5b52e645e979d21509d024e1f764afc9e8450d0e313de8b::suiwalrus {
    struct SUIWALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWALRUS>(arg0, 6, b"SuiWalrus", b"SUIWALRUS", b"Welcome to the next generation of data storage. Secure, efficient, and decentralized. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240912214341_112c677248.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

