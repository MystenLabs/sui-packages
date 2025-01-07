module 0xa4e9bc17a0f501596968aebd9661bcdf5708a3c77b7d9a9260e7cb4a863e1dc6::mpp {
    struct MPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPP>(arg0, 6, b"MPP", b"MOVE PUMP PLANET", b"MOVE PUMP PLANET IN COLORS!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/copilot_image_1728463899917_5be42bc5bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

