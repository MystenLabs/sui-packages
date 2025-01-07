module 0xa330322aba6f7f58fa610c2609bac0e55be679f0012e43b6720dd2507d93f6ff::didy {
    struct DIDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDY>(arg0, 9, b"DIDY", b"Cobra Diddy", b"Mix between 2 legends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1687753484018307072/7-qv-T9c.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

