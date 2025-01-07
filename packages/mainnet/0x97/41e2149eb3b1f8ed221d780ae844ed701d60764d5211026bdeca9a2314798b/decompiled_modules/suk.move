module 0x9741e2149eb3b1f8ed221d780ae844ed701d60764d5211026bdeca9a2314798b::suk {
    struct SUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUK>(arg0, 6, b"SUK", b"suk", b"sUk to a bUk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/duk_Ao_PG_5z4_K1whb_Xj0_P_d3fc407580.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

