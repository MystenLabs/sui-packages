module 0xffe6706df72edf8403180f665ef3d29e9f33c6debee3b989f6b2db6a60964c5c::gunni {
    struct GUNNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUNNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNNI>(arg0, 6, b"GUNNI", b"GUNNIDOGE", b"$GUNNI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbddu2tj_Xk_Rp_XEPD_Sc_Mideywo5d_X5j_V2x_Skxd5_G_Nh_Fe_Kg_c744788a40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUNNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

