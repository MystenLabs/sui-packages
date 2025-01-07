module 0x9aa65b1275c2d5340dfa706a67d19874f2ecbacdb7582990a444f1dcbe91698b::europa {
    struct EUROPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUROPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUROPA>(arg0, 6, b"Europa", b"europa", b"Jupiter's moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004799_687ce03ea5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUROPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUROPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

