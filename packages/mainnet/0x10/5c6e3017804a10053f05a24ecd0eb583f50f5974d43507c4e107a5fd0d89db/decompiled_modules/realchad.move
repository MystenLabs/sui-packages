module 0x105c6e3017804a10053f05a24ecd0eb583f50f5974d43507c4e107a5fd0d89db::realchad {
    struct REALCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALCHAD>(arg0, 6, b"REALCHAD", b"real chad on sui", b"a friend of suijak,king of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26cd5649566662da219669b02463897_048ccaad1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REALCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

