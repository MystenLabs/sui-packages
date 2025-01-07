module 0xfdb300fab312bd545376f46df691073983c57fb6035b0fea178ea8e9ec8d3394::trustkey {
    struct TRUSTKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUSTKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUSTKEY>(arg0, 9, b"TRUSTKEY", b"Trustk", b"Abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75abc66d-3762-4c5b-a001-09f8184c1223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUSTKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUSTKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

