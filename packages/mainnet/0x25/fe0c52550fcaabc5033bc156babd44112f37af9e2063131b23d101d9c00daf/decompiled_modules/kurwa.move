module 0x25fe0c52550fcaabc5033bc156babd44112f37af9e2063131b23d101d9c00daf::kurwa {
    struct KURWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURWA>(arg0, 6, b"KURWA", b"BOBER KURWA", b"Legend has it that  once sailed the wildest rivers of CryptoLand, chewing through blockchains like they were twigs. With his trusty golden chain as a compass, he dives headfirst into the most dangerous crypto waters, hunting for treasure in the form of KURWA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_08_21_33_03_c12a706221.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KURWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

