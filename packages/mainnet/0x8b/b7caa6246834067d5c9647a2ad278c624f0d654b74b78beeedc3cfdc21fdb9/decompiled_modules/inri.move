module 0x8bb7caa6246834067d5c9647a2ad278c624f0d654b74b78beeedc3cfdc21fdb9::inri {
    struct INRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INRI>(arg0, 6, b"INRI", b"JESUSCOIN", b"The \"Jesus is Here\" project is an innovative initiative that uses artificial intelligence (AI) to generate realistic images of Jesus Christ placed in contemporary contexts. These images, created by AI algorithms, depict Jesus as if he were living in ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989346966.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INRI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INRI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

