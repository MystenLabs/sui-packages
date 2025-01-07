module 0x881bccf530eddf4f21e9cf71afcbcf96d7d6d55ffef4db657494b57cbde082b2::gilly {
    struct GILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GILLY>(arg0, 6, b"GiLLY", b"Gilly SUI", b"Gilly SUI is waiting for You", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_f6edc98b5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

