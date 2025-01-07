module 0x64becfab1bf7663511d9445e7dbe40e05c204826596a6749311190230af5d47::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 9, b"RICH", b"Techrich ", b"A Computer Online Store And Decentralized Digital Freelancing platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/741484de-b0b4-4c7c-b807-8c0bec5df455.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

