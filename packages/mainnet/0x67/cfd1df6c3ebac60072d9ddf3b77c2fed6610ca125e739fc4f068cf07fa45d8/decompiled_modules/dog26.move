module 0x67cfd1df6c3ebac60072d9ddf3b77c2fed6610ca125e739fc4f068cf07fa45d8::dog26 {
    struct DOG26 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG26, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG26>(arg0, 6, b"DOG26", b"dog number", b"d=4 o=15 g=7 4 + 15 + 7 = 26 dog = 26 the dog is coded.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T4j_HJ_8v_Szz4k4og_N7g2976rx_M_Uf_Kx_J_Gudpt_G_Sp_N4ct2_X_33e7ff67e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG26>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG26>>(v1);
    }

    // decompiled from Move bytecode v6
}

