module 0x553a47f0d1af97ef53700eb342760c085f593098de918a50ddcab87649d6de36::bope {
    struct BOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPE>(arg0, 6, b"BOPE", b"bope", b"Book of PePe On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xcxc_5ae5b5ab0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

