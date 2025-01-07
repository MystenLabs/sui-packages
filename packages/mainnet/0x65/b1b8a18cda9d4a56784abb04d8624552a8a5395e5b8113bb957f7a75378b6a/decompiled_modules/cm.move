module 0x65b1b8a18cda9d4a56784abb04d8624552a8a5395e5b8113bb957f7a75378b6a::cm {
    struct CM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CM>(arg0, 6, b"CM", b"Catseus Maximus", b"CM ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Jovhfh6_G8o_LM_9k8er_Aurjq_YBMUWUS_Qy_Uizad_B1d_Vm_DV_23e85b9ecc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CM>>(v1);
    }

    // decompiled from Move bytecode v6
}

