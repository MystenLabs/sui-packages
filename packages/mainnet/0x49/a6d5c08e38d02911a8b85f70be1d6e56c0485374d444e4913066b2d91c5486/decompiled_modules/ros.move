module 0x49a6d5c08e38d02911a8b85f70be1d6e56c0485374d444e4913066b2d91c5486::ros {
    struct ROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROS>(arg0, 6, b"ROS", b"Rose on sui", b"The first floral bloom on Sui. A community-driven token, cultivating a vibrant ecosystem of beauty and growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3518_2a6452a59d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

