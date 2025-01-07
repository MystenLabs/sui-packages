module 0x301d5e67f4a10d866bf3ff4024a64ef2461a5d5f1006143eb6c629238d5529ad::hamstr {
    struct HAMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTR>(arg0, 6, b"HAMSTR", b"HAMSTER", b"HAmmmmmmmmmmmmmmmmmmmSTER. mmm...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2b648998be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

