module 0xae5ed8be5a36f2d04fd174332ada98f30a507550751ac5e4e004766f4f3b32ac::calc {
    struct CALC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALC>(arg0, 9, b"CALC", b"Calc Coin", b"A coin for the Calculus Elite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://battleozarks.com/calc.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CALC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CALC>>(v1);
    }

    // decompiled from Move bytecode v6
}

