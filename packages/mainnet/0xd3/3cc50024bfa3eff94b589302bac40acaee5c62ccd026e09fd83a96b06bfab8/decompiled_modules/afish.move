module 0xd33cc50024bfa3eff94b589302bac40acaee5c62ccd026e09fd83a96b06bfab8::afish {
    struct AFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFISH>(arg0, 6, b"AFISH", b"Angler Fish", b"Too tired to give my light in the darkness for my whole life. Finally I see the real light created by God", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihz35jwgipbffcz5a3fo3k7lxbvcblt2nhdjsi4i5ejprfxjj75dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

