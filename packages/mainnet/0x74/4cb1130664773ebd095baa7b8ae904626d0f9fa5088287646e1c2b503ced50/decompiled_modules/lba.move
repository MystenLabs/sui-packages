module 0x744cb1130664773ebd095baa7b8ae904626d0f9fa5088287646e1c2b503ced50::lba {
    struct LBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LBA>(arg0, 6, b"LBA", b"Lost Baby Alien by SuiAI", b"A curious baby alien, wandering the vast crypto galaxy, wishes to find his dad. With the help of SUAI, the baby alien explores stars, planets, and blockchain realms, asking every figure along the way, 'Are you my dad?' The journey is filled with hope, wonder, and a sprinkle of humor as the little one seeks a guiding light in the cosmic crypto universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/alien_1d42603b2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LBA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

