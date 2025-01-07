module 0xe6fa0f7a4549beb58cdc79f2c5fdbd0cb53c0a7472e539b5942481c44ff6bfa::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"Wooofmask", x"576f6f664d61736b2028574f4f4629202d205468652066756e6e6965737420646f6720696e2061206d61736b2120f09f9095f09f8ead2041206d656d65636f696e2070726f6a656374207769746820706177732d69746976656c792068696c6172696f75732076696265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8008c406-f969-474e-b7d5-379d065a5ba7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

