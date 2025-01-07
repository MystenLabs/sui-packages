module 0x4e6a1fbfac9a3515c182f5a10ad7c7c4443283fe280fd04d4212464ec83d74b7::pinio {
    struct PINIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINIO>(arg0, 6, b"PINIO", b"Wizrat", x"6920686f706520736565696e67206d65206d616b657320796f752068617070790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmehe9_Xpc_Czf_B6_V_Tqy_K_Vv_LLF_Mg_Y2_SHUK_Dx_Mk7hv5_B1_Y9_KQ_f9be8a4d56.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

