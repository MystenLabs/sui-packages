module 0xd8fb47083f4657135ee9771c5052b289deea121ff6ae670dde10f6c45987a5e5::jajajajajajajaja {
    struct JAJAJAJAJAJAJAJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAJAJAJAJAJAJAJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAJAJAJAJAJAJAJA>(arg0, 9, b"JAJAJAJAJAJAJAJA", b"BOO", b"Official token of boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAJAJAJAJAJAJAJA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAJAJAJAJAJAJAJA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAJAJAJAJAJAJAJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

