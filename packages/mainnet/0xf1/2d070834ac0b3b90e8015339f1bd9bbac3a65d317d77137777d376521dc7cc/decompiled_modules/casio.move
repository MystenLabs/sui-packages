module 0xf12d070834ac0b3b90e8015339f1bd9bbac3a65d317d77137777d376521dc7cc::casio {
    struct CASIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASIO>(arg0, 6, b"Casio", b"Casuio", b"A well-known Japanese company \"Casio\" liked $sui so much that they decided to open here now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cas_2c65222d1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

