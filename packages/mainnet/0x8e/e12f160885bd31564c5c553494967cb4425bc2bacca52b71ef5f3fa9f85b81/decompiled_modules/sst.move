module 0x8ee12f160885bd31564c5c553494967cb4425bc2bacca52b71ef5f3fa9f85b81::sst {
    struct SST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SST>(arg0, 6, b"SST", b"SUI SMOKING TRUCK", b"SUI SMOKING TRUCK IS UNSTOPPABLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUNTRUCK_TBH_2t_W_k_Fbm_Coq5zmjy_16907cdccb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SST>>(v1);
    }

    // decompiled from Move bytecode v6
}

