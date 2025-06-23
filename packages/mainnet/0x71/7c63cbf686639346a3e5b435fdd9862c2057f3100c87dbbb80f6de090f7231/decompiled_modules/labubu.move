module 0x717c63cbf686639346a3e5b435fdd9862c2057f3100c87dbbb80f6de090f7231::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"LABUBU", b"LABUBUdotSUI", b"The #1 hottest toy in Asia.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidbnksezhvr2clvwph7k2traihuzl2nydqkasz555p7pjeuuuwc6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LABUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

