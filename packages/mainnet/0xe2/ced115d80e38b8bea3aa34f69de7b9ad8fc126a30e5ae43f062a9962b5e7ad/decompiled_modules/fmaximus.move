module 0xe2ced115d80e38b8bea3aa34f69de7b9ad8fc126a30e5ae43f062a9962b5e7ad::fmaximus {
    struct FMAXIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMAXIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMAXIMUS>(arg0, 6, b"Fmaximus", b"Fishies Maximus", b"Goatseus Maximus bigger brother on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_cb900fab2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMAXIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMAXIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

