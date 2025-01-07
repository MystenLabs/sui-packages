module 0xbdeefe83e9321c7145154b35db90317134e6703c1c1b539dc4834a00e769df0d::sgb {
    struct SGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGB>(arg0, 9, b"SGB", b"RG", b"CV ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1004ac9f-1ca3-456d-8060-20b0d37c5c77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

