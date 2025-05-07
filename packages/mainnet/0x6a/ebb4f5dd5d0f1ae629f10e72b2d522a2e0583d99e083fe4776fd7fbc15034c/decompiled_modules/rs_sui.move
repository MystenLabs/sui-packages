module 0x6aebb4f5dd5d0f1ae629f10e72b2d522a2e0583d99e083fe4776fd7fbc15034c::rs_sui {
    struct RS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RS_SUI>(arg0, 9, b"rsSUI", b"rus Staked SUI", b"rsrs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/af5260a9-f969-417e-a2cc-89eaeafe3532/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

