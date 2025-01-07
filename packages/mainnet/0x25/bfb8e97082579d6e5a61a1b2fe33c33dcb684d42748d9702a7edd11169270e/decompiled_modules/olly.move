module 0x25bfb8e97082579d6e5a61a1b2fe33c33dcb684d42748d9702a7edd11169270e::olly {
    struct OLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLLY>(arg0, 6, b"OLLY", b"Olly", b"LFG with OLLY to the moooooooooooon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmexh3gr_Ga_Yx_K1_Z_Ri_Mo_Tgj_SH_Bf9mu63co_R6epmn_Zq3o_Ue3_9a38ae4035.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

