module 0xfcb1bbfbdcf9002ecfdb944793b9df24d78b0f0d25d0c1aa63996f27f77fa7a3::mbunny {
    struct MBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBUNNY>(arg0, 6, b"MBUNNY", b"Money Bunny", x"41726520796f7520726561647920746f20636861736520636172726f747320616e640a70726f666974733f204865726520636f6d6573204d6f6e65792042756e6e792c0a74686520666c756666696573742c2066756e6e696573742c20616e6420666173746573740a77617920746f206d756c7469706c7920796f75722063727970746f20647265616d730a6c696b652e2077656c6c2c2062756e6e69657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004368_30b219ffc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

