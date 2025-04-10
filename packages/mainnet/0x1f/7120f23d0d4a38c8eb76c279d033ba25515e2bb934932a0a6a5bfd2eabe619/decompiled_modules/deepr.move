module 0x1f7120f23d0d4a38c8eb76c279d033ba25515e2bb934932a0a6a5bfd2eabe619::deepr {
    struct DEEPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPR>(arg0, 6, b"Deepr", b"Deeper", b"The deeper you go, the darker the sea gets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1170_2cea4026a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

