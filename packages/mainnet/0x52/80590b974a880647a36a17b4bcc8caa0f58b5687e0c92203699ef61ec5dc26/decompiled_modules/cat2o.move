module 0x5280590b974a880647a36a17b4bcc8caa0f58b5687e0c92203699ef61ec5dc26::cat2o {
    struct CAT2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT2O>(arg0, 6, b"CAT2O", b"Cat2O", b"Cat2o on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0503_863bc6ce4c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

