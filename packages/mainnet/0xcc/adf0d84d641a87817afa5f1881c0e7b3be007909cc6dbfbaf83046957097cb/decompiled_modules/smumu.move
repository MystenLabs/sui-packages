module 0xccadf0d84d641a87817afa5f1881c0e7b3be007909cc6dbfbaf83046957097cb::smumu {
    struct SMUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUMU>(arg0, 6, b"SMUMU", b"Sui Mumu", b"$MUMU OG Bull Market Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6819_8591929254.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

