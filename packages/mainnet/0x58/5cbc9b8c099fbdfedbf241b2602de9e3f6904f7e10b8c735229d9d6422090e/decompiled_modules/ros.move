module 0x585cbc9b8c099fbdfedbf241b2602de9e3f6904f7e10b8c735229d9d6422090e::ros {
    struct ROS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROS>>(0x2::coin::mint<ROS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROS>(arg0, 9, b"ROS", b"ROS", b"ROS", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

