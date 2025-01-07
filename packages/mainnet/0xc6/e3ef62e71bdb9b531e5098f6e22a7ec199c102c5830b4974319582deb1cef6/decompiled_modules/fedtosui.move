module 0xc6e3ef62e71bdb9b531e5098f6e22a7ec199c102c5830b4974319582deb1cef6::fedtosui {
    struct FEDTOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEDTOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEDTOSUI>(arg0, 6, b"FEDtoSUI", b"JeromePowell", b"How much do you want to reduce interest rates?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_32a5345033.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEDTOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEDTOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

