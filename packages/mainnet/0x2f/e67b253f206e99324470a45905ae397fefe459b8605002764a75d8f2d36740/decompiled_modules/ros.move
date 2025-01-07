module 0x2fe67b253f206e99324470a45905ae397fefe459b8605002764a75d8f2d36740::ros {
    struct ROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROS>(arg0, 6, b"ROS", b"Ratatouille on SUI", x"48657920666f6f64696520667269656e647321200a49276d2052617461746f75696c6c652c20796f75722070696e742d73697a6564206368656620776974682062696720647265616d7320616e6420616e206576656e206269676765722068656172742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_17_15_27_4da359f5a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

