module 0xa551b0b4a6775cf42a01c9ce701ccd19e2c6ac7664590b2d045d154ec3e69aa9::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FIRE>(arg0, 6, b"FIRE", b"Fire AI by SuiAI", b"This token embodies the fire burning in every crypto degen. We are explorers. We continue to search for the promise of a true system for the people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_11_15_130709_2a938d92f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

