module 0x85418816c3c3439a00e1b6de468c69798bdb5573a14b0cf8b31f2a380763fbf7::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROP>(arg0, 9, b"AIRDROP", b"Drwizzy", b"Nenecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37785710-d809-4d7a-984f-61fb0b254a0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIRDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

