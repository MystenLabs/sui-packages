module 0x55be371ce38ce2430d47b9671f809ea4ed370ed475e5be99de39ce7b2f69fd::suige {
    struct SUIGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGE>(arg0, 6, b"SUIGE", b"Suige", b"Suige a dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2467_298ea0d5a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

