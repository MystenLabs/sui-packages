module 0x41e9a724c2fa31b0a11544302d7d0dd59a88180b3a97b92771abb0f0c179a5a3::dwolf {
    struct DWOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOLF>(arg0, 6, b"DWOLF", b"DWolf", b"The biggest & baddest character on Sui...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_42e15e2fd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

