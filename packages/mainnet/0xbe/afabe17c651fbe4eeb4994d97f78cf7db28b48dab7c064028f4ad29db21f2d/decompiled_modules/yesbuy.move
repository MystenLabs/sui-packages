module 0xbeafabe17c651fbe4eeb4994d97f78cf7db28b48dab7c064028f4ad29db21f2d::yesbuy {
    struct YESBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YESBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YESBUY>(arg0, 6, b"YESBUY", b"YES BUY THAT", b"u need the buy that for no reason.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_496603666_612x612_17926b23a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YESBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YESBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

