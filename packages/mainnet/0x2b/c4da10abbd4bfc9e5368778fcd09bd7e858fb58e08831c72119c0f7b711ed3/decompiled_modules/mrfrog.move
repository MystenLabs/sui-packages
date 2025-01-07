module 0x2bc4da10abbd4bfc9e5368778fcd09bd7e858fb58e08831c72119c0f7b711ed3::mrfrog {
    struct MRFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRFROG>(arg0, 6, b"MrFrog", b"Mr. Frog", b"Some of us are going to make it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_V_Br_T2_Sv_400x400_c53c6f7402.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

