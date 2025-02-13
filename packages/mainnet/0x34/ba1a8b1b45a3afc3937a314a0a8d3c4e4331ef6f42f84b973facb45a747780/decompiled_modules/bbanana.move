module 0x34ba1a8b1b45a3afc3937a314a0a8d3c4e4331ef6f42f84b973facb45a747780::bbanana {
    struct BBANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBANANA>(arg0, 9, b"BBANANA", b"BLK BANANA", b"BANANA NA NA NAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88379815-24ab-42a8-a08e-13e0e622bd85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

