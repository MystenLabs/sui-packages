module 0x7edae5b6f6abd5019c8e5cff1373193941fe0cf34acde5900fad31c073c0ea8c::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 9, b"GREEN", b"GREEN", b"Make Greenland green again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1790738036046635008/8_18wDPH_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GREEN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

