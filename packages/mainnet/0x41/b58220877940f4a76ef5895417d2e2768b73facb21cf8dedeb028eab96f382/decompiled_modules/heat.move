module 0x41b58220877940f4a76ef5895417d2e2768b73facb21cf8dedeb028eab96f382::heat {
    struct HEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAT>(arg0, 9, b"DEGREE", b"HEAT", b"https://energyeducation.ca/wiki/images/thumb/9/95/Fire.jpg/350px-Fire.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAT>>(v1);
        0x2::coin::mint_and_transfer<HEAT>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

