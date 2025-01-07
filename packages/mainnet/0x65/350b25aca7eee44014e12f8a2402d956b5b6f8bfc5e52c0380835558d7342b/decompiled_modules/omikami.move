module 0x65350b25aca7eee44014e12f8a2402d956b5b6f8bfc5e52c0380835558d7342b::omikami {
    struct OMIKAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMIKAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMIKAMI>(arg0, 6, b"OMIKAMI", b"AMATERASU OMIKAMI", b"The Omikami token is our foundational currency that allows investors to hold hundreds, thousands, or even millions, of it in their wallets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/omikami_79e4e38716.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMIKAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMIKAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

