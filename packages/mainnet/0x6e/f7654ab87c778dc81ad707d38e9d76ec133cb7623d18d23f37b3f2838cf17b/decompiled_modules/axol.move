module 0x6ef7654ab87c778dc81ad707d38e9d76ec133cb7623d18d23f37b3f2838cf17b::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOL>(arg0, 6, b"AXOL", b"Baby Axol Coin", b"Community claimed, fair re-launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/att_k_Do8_S2xlv_WIFW_4c_Z_8l_FJFM_6_vj69_Ip_OMDXPV_0rmu4_e8b67d006e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

