module 0x635c86e43b2ea9b04a41d16daa1138fd7ac06c29381ffc29051841ba54ccfec9::suikore69 {
    struct SUIKORE69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKORE69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKORE69>(arg0, 6, b"SUIKORE69", b"Suitel Kore i69", x"3639204d206b656b652c20416f732049656e206170204936392d3432303030303058585820435055555555555520746f6f20362c363647687a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1294195jcreqdfj919jfj91923_c19947afa2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKORE69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKORE69>>(v1);
    }

    // decompiled from Move bytecode v6
}

