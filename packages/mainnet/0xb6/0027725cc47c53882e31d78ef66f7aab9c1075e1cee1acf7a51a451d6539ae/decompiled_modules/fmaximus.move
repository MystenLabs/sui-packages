module 0xb60027725cc47c53882e31d78ef66f7aab9c1075e1cee1acf7a51a451d6539ae::fmaximus {
    struct FMAXIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMAXIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMAXIMUS>(arg0, 6, b"Fmaximus", b"Fishies Maximus", b"Goatseus Maximus bigger brother on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_62515f9e26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMAXIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMAXIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

