module 0xfa7cfe3eab42653c65a4b9dd81481ae604607b23e774862b30a57e3e3992fc43::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"Goku", b"Goku on sui", b"Goku is here to stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2522_8a6c3c60ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

