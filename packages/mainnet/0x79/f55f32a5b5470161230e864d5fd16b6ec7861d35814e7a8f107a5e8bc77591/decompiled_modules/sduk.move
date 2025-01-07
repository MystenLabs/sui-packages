module 0x79f55f32a5b5470161230e864d5fd16b6ec7861d35814e7a8f107a5e8bc77591::sduk {
    struct SDUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUK>(arg0, 6, b"SDUK", b"DUK ON SUI", b"you like memes? we $SDUK those too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zop_O_Gv_Xk_AE_Vd_FE_d7fb6bfda7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

