module 0x14ce57d208ceb0bfcd745ed494a17879815ccae7c7f7ecf1644ba62d85d84e0b::ros {
    struct ROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROS>(arg0, 9, b"ROS", b"Restocking", x"4920646f6ee2809974207468696e6b20736f2049207468696e6b2077", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3cb227a-c8ae-449a-a9ca-cfcb53c33561.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

