module 0xba9f3c6e9fbdd02fb03608c5e7a087059374f68a25f999f683146b73d77ed685::suiniper {
    struct SUINIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIPER>(arg0, 6, b"SUINIPER", b"Sui Sniper", x"245355494e4950455220697320796f75722073656372657420776561706f6e20696e2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_77_8d3dcbdda1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

