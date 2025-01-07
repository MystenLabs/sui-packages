module 0xf71ec32e23b67abb08d4e0454bd2083974ded4df3e86cb2d34fafc7a2b343be4::supig {
    struct SUPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPIG>(arg0, 6, b"SUPIG", b"Sui Pig", b"SUPIG is a degen by night, also degen and gambler by day. I'm sure You have a lot in common.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_TGTW_c1d9e9e878.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

