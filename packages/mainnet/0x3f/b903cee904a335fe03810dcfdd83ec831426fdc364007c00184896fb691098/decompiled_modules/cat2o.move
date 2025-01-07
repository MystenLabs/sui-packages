module 0x3fb903cee904a335fe03810dcfdd83ec831426fdc364007c00184896fb691098::cat2o {
    struct CAT2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT2O>(arg0, 6, b"CAT2O", b"Cat2O", b"CAT2O on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0503_75d4b0edd4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

