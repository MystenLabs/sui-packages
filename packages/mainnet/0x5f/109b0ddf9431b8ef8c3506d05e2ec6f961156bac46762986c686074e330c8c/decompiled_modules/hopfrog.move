module 0x5f109b0ddf9431b8ef8c3506d05e2ec6f961156bac46762986c686074e330c8c::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFROG>(arg0, 6, b"HopFrog", b"HopFrogSui", b"First Frog on Hop Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOP_FROG_076aa00f54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

