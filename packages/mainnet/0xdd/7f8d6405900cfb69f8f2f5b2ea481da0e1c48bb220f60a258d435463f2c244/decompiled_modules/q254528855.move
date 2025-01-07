module 0xdd7f8d6405900cfb69f8f2f5b2ea481da0e1c48bb220f60a258d435463f2c244::q254528855 {
    struct Q254528855 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q254528855, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q254528855>(arg0, 9, b"Q254528855", b"WAVE 11", b"Get rich together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91d8a8a7-860a-445a-8446-a280b805abeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q254528855>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q254528855>>(v1);
    }

    // decompiled from Move bytecode v6
}

