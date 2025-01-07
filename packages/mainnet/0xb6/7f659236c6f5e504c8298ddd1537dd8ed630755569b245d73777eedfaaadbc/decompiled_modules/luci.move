module 0xb67f659236c6f5e504c8298ddd1537dd8ed630755569b245d73777eedfaaadbc::luci {
    struct LUCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCI>(arg0, 6, b"LUCI", b"Lil Demon", b"Cute demon chilling in a very warm place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zqlc1_HT_7_400x400_1886da4685.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

