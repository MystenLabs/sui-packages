module 0x7bb45525001b2a7acad123966d91f2d76a4403ccda93db415969e62fc3d8202c::slutpfp {
    struct SLUTPFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUTPFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUTPFP>(arg0, 6, b"SLUTPFP", b"SLUTPFP SUI", x"4a6f696e207468652023536c7574706670205820436f6d6d756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_JQ_1_Ly_v_400x400_631c6e1696.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUTPFP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUTPFP>>(v1);
    }

    // decompiled from Move bytecode v6
}

