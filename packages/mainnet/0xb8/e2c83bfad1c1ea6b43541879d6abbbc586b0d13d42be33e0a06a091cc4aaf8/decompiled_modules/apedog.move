module 0xb8e2c83bfad1c1ea6b43541879d6abbbc586b0d13d42be33e0a06a091cc4aaf8::apedog {
    struct APEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEDOG>(arg0, 6, b"Apedog", b"Apple dog", x"546865204170706c6520446f67206861732063686f73656e2069747320636861696e2e0a24535549206973206e6f77206f6666696369616c6c7920626c6573736564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifyow6dz2veyi24pu7yn466r4e2xmfklwbjkfwlvhgjtar33llsce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

