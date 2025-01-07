module 0x976dd8e2c9154528d3eed173cb01afa7eaabfe9776a4bd4a77f81a399ebee4ba::penbe {
    struct PENBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENBE>(arg0, 9, b"PENBE", b"idjd", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92c17df1-6f98-48b8-b72a-65d80fba1f52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

