module 0x59a50b00a411538cd387a0a65645bb4cbe40cc393dc8770c1e353febe7c61af7::redbull {
    struct REDBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDBULL>(arg0, 6, b"REDBULL", b"RED BULL RACING", b"Oracle Champions collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://1000logos.net/wp-content/uploads/2017/05/Red-Bull-emblems.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REDBULL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

