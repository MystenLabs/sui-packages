module 0x8a7cdb95690f9562b4cd39f32babaacd5cdc9b85380f9317286cd3a2554000ef::sael {
    struct SAEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAEL>(arg0, 6, b"SAEL", b"King Sael", b"Sael is an innovative memecoin on the Sui blockchain with modern style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeica6afdknzj7lsdd7jw2alm3beewcaixnsnuhr6dmhy3iw2ho5x5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

