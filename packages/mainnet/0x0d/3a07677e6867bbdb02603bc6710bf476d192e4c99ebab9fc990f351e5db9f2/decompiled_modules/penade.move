module 0xd3a07677e6867bbdb02603bc6710bf476d192e4c99ebab9fc990f351e5db9f2::penade {
    struct PENADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENADE>(arg0, 6, b"PENADE", b"PEPENADE", x"54686973206973207374726f6e676572207468616e2061207065636c65617220626f6d622e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6d07bf8d65cf049a09186448ad78db4c_57af3f7210.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

