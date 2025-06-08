module 0x9cb5b95f06e1c36231cf6846e5c2617a28513325aab71a53e6545bf2954686a0::mun {
    struct MUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN>(arg0, 6, b"MUN", b"Munkidori on sui", b"Welcome to the $MUNKI era on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichi3pxlps3ri7iv5ii4so4mqoi4be2uzbmbov2wgrmsp2bsokvda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

