module 0x88fd38723e7dcda45899a61e24b39237f5252816c0f6c0f30dddddce8fa87015::holly {
    struct HOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLLY>(arg0, 6, b"Holly", b"Holly25", b"Holiday cheers and new years blessing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241224_193124_Whats_App_Business_0c64f5ac6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

