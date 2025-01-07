module 0x682622a7042181376d817189c95d0ebe3eb299d94e10f1270257e7d8cf9968d5::mesui {
    struct MESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESUI>(arg0, 6, b"MESUI", b"MESiUUUUUUUU", b"THE ONLY THING THAT JOIN THE GOAT TOGHETHER LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_9_9c07eead17.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

