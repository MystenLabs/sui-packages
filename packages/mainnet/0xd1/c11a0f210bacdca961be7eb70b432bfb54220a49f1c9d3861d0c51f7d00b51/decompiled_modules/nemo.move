module 0xd1c11a0f210bacdca961be7eb70b432bfb54220a49f1c9d3861d0c51f7d00b51::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"Sui Nemo", x"4d656574205375694e656d6f3a2074686520666973682077686f2773206a757374206b656570696e27207377696d6d696e67207468726f7567682074686520626c6f636b636861696e2077617665732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Hz_Tj78u_400x400_c7275249e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

