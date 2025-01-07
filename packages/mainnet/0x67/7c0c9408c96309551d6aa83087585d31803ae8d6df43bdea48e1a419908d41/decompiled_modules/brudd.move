module 0x677c0c9408c96309551d6aa83087585d31803ae8d6df43bdea48e1a419908d41::brudd {
    struct BRUDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUDD>(arg0, 6, b"BRUDD", b"SUI  BRUDD", b"he Leading Meme coin on SUI. BRUDD is the Legendary Character created by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mpuu_T_Ql_O_400x400_1_ef953d7cfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

