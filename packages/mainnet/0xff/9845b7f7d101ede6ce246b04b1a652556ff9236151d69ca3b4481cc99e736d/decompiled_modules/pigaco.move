module 0xff9845b7f7d101ede6ce246b04b1a652556ff9236151d69ca3b4481cc99e736d::pigaco {
    struct PIGACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGACO>(arg0, 6, b"Pigaco", b"pigaco", b"ART", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_ae_6_a68c423bf0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

