module 0xd602d2a9eb0c4f4994fd3304c14aa050630b9165595f13a8e7da85ce4dc360ef::turtle {
    struct TURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLE>(arg0, 9, b"TURTLE", b"TURTLE", x"4120636f6d6d756e6974792066756e20746f6b656e20696e7370697265642062792050617461726120f09f90a2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/Kx8QGyJ.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TURTLE>(&mut v2, 69420000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLE>>(v2, @0x99fdfac6737ccacff82508b45b1b5e04f09272e22456ffa57444f01c6277f04f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

