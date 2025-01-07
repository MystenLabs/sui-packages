module 0x11cb0e4a96d749ed323aa50eb304b4564c9ef713495a5d881bc3166bbec7a1b5::docius {
    struct DOCIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOCIUS>(arg0, 6, b"DOCIUS", b"Suicalifragilistic", b"Suicalifragilisticexpialidocious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030354_5bdf892f03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOCIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOCIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

