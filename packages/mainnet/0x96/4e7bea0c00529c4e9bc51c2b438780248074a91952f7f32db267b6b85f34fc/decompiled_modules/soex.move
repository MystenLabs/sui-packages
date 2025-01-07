module 0x964e7bea0c00529c4e9bc51c2b438780248074a91952f7f32db267b6b85f34fc::soex {
    struct SOEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOEX>(arg0, 9, b"SOEX", b"SOLOMON ", b"New Age cryptocurrency jjaj ajeh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2617f2a9-0e44-43d4-b846-6fd462a62690.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

