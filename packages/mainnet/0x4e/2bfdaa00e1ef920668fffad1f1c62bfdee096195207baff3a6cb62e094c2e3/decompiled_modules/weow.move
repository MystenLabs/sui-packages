module 0x4e2bfdaa00e1ef920668fffad1f1c62bfdee096195207baff3a6cb62e094c2e3::weow {
    struct WEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEOW>(arg0, 9, b"WEOW", b"SINE", b"SINE is a name inspired by the sporit of advaenture and freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34f16e17-b856-4731-8f3c-63177ecfb001.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

