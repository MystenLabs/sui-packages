module 0x567c99daa85aa75a45c024b1e2524455c229642432aa4fccbfe7cacd022c4efd::ros {
    struct ROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROS>(arg0, 6, b"ROS", b"Raccoon", b"RaccoonOnSui don't have social media, from community to community.. Keep stronger !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241122_WA_0013_06cd63a69c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

