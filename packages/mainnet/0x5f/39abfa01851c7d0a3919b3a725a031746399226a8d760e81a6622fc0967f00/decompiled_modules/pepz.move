module 0x5f39abfa01851c7d0a3919b3a725a031746399226a8d760e81a6622fc0967f00::pepz {
    struct PEPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPZ>(arg0, 9, b"PEPZ", b"PEPERONI", b"PEPERONI is a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b69f9f9-09e1-4598-b4fe-c948a9a620fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

