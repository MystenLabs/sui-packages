module 0x66df75140b1880bfb4eff130d0103317745cf7a30ed8f7c86b81544f142f79cc::toad {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAD>(arg0, 6, b"TOAD", b"The Obviously Autistic Doge", b"Invest in $TOAD today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_f74efcffb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

