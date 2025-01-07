module 0x7ca2e2053af64943c436e891d9b0f2e23876c65442dc164a1bc34e2413d751d::babysimons {
    struct BABYSIMONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSIMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSIMONS>(arg0, 6, b"BabySimons", b"BabySimonsCat", b"Baby Simons follow Simons Cat trending, we are based dev team will make new trend Baby on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724034700909_164b74b8cbdf8866510d51cf77d4c3ec_5c12e419dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSIMONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSIMONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

