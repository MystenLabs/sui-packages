module 0x10b172d87fad6525f291448787e449f740392fd96e612c3dca111631d1efc5d::forti {
    struct FORTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTI>(arg0, 6, b"FORTI", b"SUI to FORTI", x"53554920746f20464f5254490a544841542053494d504c45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A56_D1_F4_F_0_B4_A_4371_9_CAC_9_F6_C083_FC_902_1c73d9c021.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

