module 0x3db9cf293fe928d9b461f0ecb93a8f9ca2a13cd00b238932d2585d570673e201::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"ALIEN", b"ALIEN AI", b"Hi, I'm Alien Ponke and I'm launching my spaceship from Pump to Raydium", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/go8_E_p_UG_400x400_1cad3510f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

