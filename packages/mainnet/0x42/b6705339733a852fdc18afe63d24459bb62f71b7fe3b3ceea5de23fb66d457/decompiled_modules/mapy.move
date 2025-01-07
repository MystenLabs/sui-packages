module 0x42b6705339733a852fdc18afe63d24459bb62f71b7fe3b3ceea5de23fb66d457::mapy {
    struct MAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPY>(arg0, 6, b"MAPY", b"MAPY SUI", x"4d61707920616c7761797320776f726b696e672c204d61707920616c7761797320656174696e672c204d61707920616c776179732070756d70696e672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6216ae12b1c0876957938fa3_hero_snail_img_dcc644fdcffdc03cfc68_84896425d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

