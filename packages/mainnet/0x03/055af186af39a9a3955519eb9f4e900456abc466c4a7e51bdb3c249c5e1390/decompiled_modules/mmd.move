module 0x3055af186af39a9a3955519eb9f4e900456abc466c4a7e51bdb3c249c5e1390::mmd {
    struct MMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMD>(arg0, 6, b"MMD", b"MemeDollars", b"Take a blue dollar if you don't have a green dollar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chad_a5a7db24abe94b2687f304e5f937db35_dba987583c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

