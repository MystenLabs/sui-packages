module 0xce55c09327370a51aaaa4ede5ff5f3d34cacc5ea9209db308bd02a41728a61b2::ryve {
    struct RYVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYVE>(arg0, 6, b"RYVE", b"RYVE AI", b"Ryve  | Powered by DeepSeek V3 AI  | We analyze & predict the best crypto projects for smart investments ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/679942b4b9703b83c5179cee_ryve_logo_2x_upd_2_fc6fddf0a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

