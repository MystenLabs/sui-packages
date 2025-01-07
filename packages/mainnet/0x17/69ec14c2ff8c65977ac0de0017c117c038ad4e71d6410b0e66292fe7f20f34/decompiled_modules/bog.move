module 0x1769ec14c2ff8c65977ac0de0017c117c038ad4e71d6410b0e66292fe7f20f34::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"BOG", b"BOG - The Frog Father", b"Matt Furie created $BOG in 2004 and Oldest mascot than $PEPE $HOPPY $FEFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_e08961d53c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

