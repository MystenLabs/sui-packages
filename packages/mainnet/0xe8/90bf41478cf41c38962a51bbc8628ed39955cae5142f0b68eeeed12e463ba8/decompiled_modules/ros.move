module 0xe890bf41478cf41c38962a51bbc8628ed39955cae5142f0b68eeeed12e463ba8::ros {
    struct ROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROS>(arg0, 6, b"ROS", b"Apt", x"4170617465752c206170617465750a0a55682c2075682d6875682c2075682d687568", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087904_0a74285fcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

