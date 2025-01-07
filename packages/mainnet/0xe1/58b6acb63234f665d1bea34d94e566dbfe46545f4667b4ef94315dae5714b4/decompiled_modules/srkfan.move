module 0xe158b6acb63234f665d1bea34d94e566dbfe46545f4667b4ef94315dae5714b4::srkfan {
    struct SRKFAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRKFAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRKFAN>(arg0, 9, b"SRKFAN", b"SRK", b"We are SRKFAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae1d6a00-fab2-490b-af68-5f0567324e91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRKFAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRKFAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

