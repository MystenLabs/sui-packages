module 0x298e9e8ee90294e1b0602a1b9f145982295ac35a7f2a035fae86b8138075f956::chicoin47 {
    struct CHICOIN47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICOIN47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICOIN47>(arg0, 9, b"CHICOIN47", b"Chizzy", b"Simplicity taking you to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/930f6381-3ba3-41f7-b34f-ef6151254a7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICOIN47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICOIN47>>(v1);
    }

    // decompiled from Move bytecode v6
}

