module 0x1b6ffdeec164912a5b1c4a72cc96ede2fbd6524072c20ab7c95410cee9557296::wcar {
    struct WCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAR>(arg0, 9, b"WCAR", b"WIZARD CAR", x"205741564520f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f14e5f1-900b-49cf-95f7-831aeab28877.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

