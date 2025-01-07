module 0x8fbe08a56e0bda146b94d97887b5075241145158b76d5c1db61e57be58e31fab::smurfwifgun {
    struct SMURFWIFGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFWIFGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFWIFGUN>(arg0, 6, b"SMURFWIFGUN", b"Smurf Wif Gun", x"484546545920534d55524620414e442047524f5543485920534d555246200a5354415220494e2041204e4557204d4f564945205449544c45440a22534d555246205749462047554e22205748455245205448455920504c414e20544f20535449434b205550205448452053554920424c4f434b434841494e210a0a434f4d4d554e495459204d454d4520544f4b454e210a534f4349414c5320434f4d494e4720534f4f4e21210a504c45415345204645454c204652454520544f204255494c44205745425349544521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Polish_20241121_105247335_a4d56f3cb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFWIFGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFWIFGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

