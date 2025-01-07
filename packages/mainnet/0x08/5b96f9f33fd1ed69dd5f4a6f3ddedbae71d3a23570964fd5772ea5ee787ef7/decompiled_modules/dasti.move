module 0x85b96f9f33fd1ed69dd5f4a6f3ddedbae71d3a23570964fd5772ea5ee787ef7::dasti {
    struct DASTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASTI>(arg0, 6, b"DASTI", b"Dastish Fantastish", b"#DASTI - the coolest girl among memecoins! Hold on tight, it's going to be hot! I'm the star that the world revolves around!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_568a02bb46.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DASTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

