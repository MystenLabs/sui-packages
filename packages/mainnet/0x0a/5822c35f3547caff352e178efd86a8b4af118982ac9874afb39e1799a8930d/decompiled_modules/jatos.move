module 0xa5822c35f3547caff352e178efd86a8b4af118982ac9874afb39e1799a8930d::jatos {
    struct JATOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JATOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JATOS>(arg0, 6, b"JATOS", b"Just A Token On Sui", b"Just A Token On Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9271_24697b799b.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JATOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JATOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

