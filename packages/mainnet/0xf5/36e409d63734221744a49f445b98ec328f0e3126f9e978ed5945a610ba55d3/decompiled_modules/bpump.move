module 0xf536e409d63734221744a49f445b98ec328f0e3126f9e978ed5945a610ba55d3::bpump {
    struct BPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUMP>(arg0, 6, b"BPUMP", b"BLUE MOVE", b"COMMUNITY TAKE OVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/97b3b9e0_c8a2_4307_a1ad_cb2b375fd5fd_fab948a6d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

