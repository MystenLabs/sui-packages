module 0xaca8730a5d38aa39bd916252f10d74e0c4d641f0907446126cf2bcf820a0d82c::beard {
    struct BEARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BEARD>(arg0, 6, b"BEARD", b"Blue Beard by SuiAI", b"Bluebeard is not just a meme - it is a cult movement of the Sui ecosystem! Join us and wear your blue beard with pride! Soon everyone in the SUI ecosystem will be sporting a blue beard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BEARD_a92967b5fa_2b2c32e249.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEARD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

