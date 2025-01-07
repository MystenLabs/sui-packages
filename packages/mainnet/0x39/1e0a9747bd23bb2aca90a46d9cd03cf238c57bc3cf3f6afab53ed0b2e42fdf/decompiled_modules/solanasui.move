module 0x391e0a9747bd23bb2aca90a46d9cd03cf238c57bc3cf3f6afab53ed0b2e42fdf::solanasui {
    struct SOLANASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANASUI>(arg0, 6, b"SOLANASUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANASUI>>(v1);
        0x2::coin::mint_and_transfer<SOLANASUI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANASUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

