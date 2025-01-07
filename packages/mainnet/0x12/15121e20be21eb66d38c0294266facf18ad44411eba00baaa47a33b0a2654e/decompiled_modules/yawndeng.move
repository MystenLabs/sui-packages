module 0x1215121e20be21eb66d38c0294266facf18ad44411eba00baaa47a33b0a2654e::yawndeng {
    struct YAWNDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWNDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWNDENG>(arg0, 6, b"YAWNDENG", b"yawndeng", x"245941574e44454e4720746865204269672042726f74686572206f6620796f75206b6e6f772077686f2120272720536c6f7720616e64207374656164792077696e732074686520726163652e222043544f20544f4b454e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YAWNDENG_TB_15_Um_Kp0fvy_Nz3_OQG_54b0056857.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWNDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWNDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

