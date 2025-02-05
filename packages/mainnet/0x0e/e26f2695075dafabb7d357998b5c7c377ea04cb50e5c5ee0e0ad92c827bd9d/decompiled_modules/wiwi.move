module 0xee26f2695075dafabb7d357998b5c7c377ea04cb50e5c5ee0e0ad92c827bd9d::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWI>(arg0, 9, b"WIWI", b"WIWI AI", b"WIWI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d58399c-56c5-4aa3-a44c-e1ab33c2c12e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

