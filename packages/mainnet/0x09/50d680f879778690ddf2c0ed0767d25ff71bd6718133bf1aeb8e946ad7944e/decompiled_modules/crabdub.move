module 0x950d680f879778690ddf2c0ed0767d25ff71bd6718133bf1aeb8e946ad7944e::crabdub {
    struct CRABDUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABDUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABDUB>(arg0, 6, b"CRABDUB", b"Crab Dub", b"Just clipping and dubbing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crabbbyyyyy_399c639368.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABDUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABDUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

