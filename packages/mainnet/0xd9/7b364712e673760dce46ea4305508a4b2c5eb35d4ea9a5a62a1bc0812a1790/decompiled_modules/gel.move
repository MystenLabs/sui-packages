module 0xd97b364712e673760dce46ea4305508a4b2c5eb35d4ea9a5a62a1bc0812a1790::gel {
    struct GEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEL>(arg0, 9, b"GEL", b"Sakartvelo", b"Georgian Gel token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9526ff8-d335-42d1-a8e5-fd374d672e13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

