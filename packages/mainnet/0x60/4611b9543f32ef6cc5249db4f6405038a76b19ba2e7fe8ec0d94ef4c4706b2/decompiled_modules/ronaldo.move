module 0x604611b9543f32ef6cc5249db4f6405038a76b19ba2e7fe8ec0d94ef4c4706b2::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 9, b"RONALDO", x"e29abd2053756969696969696969696969", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONALDO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

