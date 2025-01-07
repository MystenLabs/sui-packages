module 0x75d3fe6ed3a598b32c7b2d83d1838ea0e7b767cb1f400e35ca46ba013fd74992::mcagain {
    struct MCAGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAGAIN>(arg0, 6, b"McAGAIN", b"McGreat", b"McGreat AGAIN...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MC_5c5678277e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCAGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

