module 0xf01ee9aa2fec5cdf4694cc4c61870108d182260ccc54a1e6fee04bba370d5b6d::new {
    struct NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW>(arg0, 9, b"NEW", b"New Game", b"I create this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/media/GZWK4GiXIAAg9ZO?format=jpg&name=medium"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEW>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

