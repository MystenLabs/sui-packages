module 0x4c5004cc43b9ff22e19efcc853a45bd3afa42b5562362aeeff147e5c19830248::lsvp {
    struct LSVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSVP>(arg0, 6, b"LSVP", b"LIGHTSPEED", b"Possibility grows the deeper you go. Serving bold builders of the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5keowf4rnk3eytejwhap4dlcyc2fnlddmnqg37z4zybca2vxhsq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LSVP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

