module 0xc9f185cdb429325d9c987c5e006621d85a4263d6360205a848498741b9b25608::ratio {
    struct RATIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATIO>(arg0, 9, b"RATIO", b"RATIONAL", b"Dive in and experience the fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29f44072-83a5-49bc-a62f-ef224348632f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

