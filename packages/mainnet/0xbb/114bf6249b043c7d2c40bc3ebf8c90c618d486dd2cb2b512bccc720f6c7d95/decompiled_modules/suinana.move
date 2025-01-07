module 0xbb114bf6249b043c7d2c40bc3ebf8c90c618d486dd2cb2b512bccc720f6c7d95::suinana {
    struct SUINANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINANA>(arg0, 6, b"SUINANA", b"BANANA on SUI", b"The first banana will skyrocket in space with Elon Musk's rocket. Don't fall again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gcw_Ft0_N_Xg_AA_7_F_Cx_564581efad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

