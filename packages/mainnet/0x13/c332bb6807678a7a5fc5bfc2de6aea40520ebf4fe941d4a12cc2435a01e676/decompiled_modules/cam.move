module 0x13c332bb6807678a7a5fc5bfc2de6aea40520ebf4fe941d4a12cc2435a01e676::cam {
    struct CAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAM>(arg0, 6, b"CAM", b"Elevator cam Ai", b"Ai is watching you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cam_78aaf9b215.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

