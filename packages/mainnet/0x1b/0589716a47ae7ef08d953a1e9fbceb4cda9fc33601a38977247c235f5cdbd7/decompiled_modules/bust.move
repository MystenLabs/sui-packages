module 0x1b0589716a47ae7ef08d953a1e9fbceb4cda9fc33601a38977247c235f5cdbd7::bust {
    struct BUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUST>(arg0, 6, b"BUST", b"GigaBust Token", b"The GigaBust is coming.. and its going to be BIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2126_d6e89fb38a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

