module 0x4da49703f732f329596bec74c6ae34f4924ae0454f0df95d8088c3a7757cae8c::badd0g {
    struct BADD0G has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADD0G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADD0G>(arg0, 6, b"BADD0G", b"BADD0G on SUI", x"6c697665206c617567682062726f73206c6f76652e20626f742f61726368697665206163636f756e7420666f7220616b69746f7579612e20747765657473206576657279206f7468657220686f7572200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S0g_O_Qz_Bm_400x400_03fe6769e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADD0G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADD0G>>(v1);
    }

    // decompiled from Move bytecode v6
}

