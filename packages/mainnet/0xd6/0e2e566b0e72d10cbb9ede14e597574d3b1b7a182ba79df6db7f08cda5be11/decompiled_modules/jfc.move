module 0xd60e2e566b0e72d10cbb9ede14e597574d3b1b7a182ba79df6db7f08cda5be11::jfc {
    struct JFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFC>(arg0, 6, b"JFC", b"Jackie Fine Chicken", b"He's no longer sharing chicken, but he's serving these gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KF_Cs_Colonel_Sanders_joins_a_group_of_strippers_in_raunchy_Mothers_Day_video_Elite_Franchise_f76d1e6869.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

