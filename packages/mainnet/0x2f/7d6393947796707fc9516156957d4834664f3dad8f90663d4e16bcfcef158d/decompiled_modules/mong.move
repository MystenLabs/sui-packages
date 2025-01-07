module 0x2f7d6393947796707fc9516156957d4834664f3dad8f90663d4e16bcfcef158d::mong {
    struct MONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONG>(arg0, 9, b"MONG", b"Among", b"A man destined to be a Casanova", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2043302a-70d0-4563-9225-ced1cfab586f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

