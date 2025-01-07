module 0xef0c9219b58f77725dc699274610a9a93aaade7ca4d961f14c852048e8c0eeb6::squiddy {
    struct SQUIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDDY>(arg0, 9, b"SQUIDDY", b"Squiddy", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDGH7sW3mJ-LyqoMc7NQMVj_aqamwfilzyig&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIDDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

