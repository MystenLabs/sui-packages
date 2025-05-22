module 0xd92b531763fc2852a2997736d03d25850c12319013c01c4e959173311b6bb81c::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"HIPPO SPLASH", x"496e74726f647563696e6720687474703a2f2f53706c6173682e78797a200a0a4c61756e636820746f6b656e73206f6e205375692e20496e7374616e746c792e20466169726c792e0a4275696c7420666f72206275696c646572732c20646567656e732c20616e642065766572796f6e6520696e206265747765656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexr46fsx56hpso27e27ccumf6soykizzjkwvxjtdpgozyfp25boa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

