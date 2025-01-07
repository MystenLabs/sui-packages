module 0xf01eac265a10f5ed42786d898ab3e0a3083b4318704f07749241e1954223daf::exxx {
    struct EXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXXX>(arg0, 9, b"EXXX", b"excel", b"EXXXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23e2f42a-ca00-4b48-90b2-34eb0cfb0f8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

