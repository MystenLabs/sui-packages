module 0xc96501ad52776c530ad24b99ea655d581242ec6efd3fbbc484ee9612f6091f83::tigra {
    struct TIGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGRA>(arg0, 6, b"Tigra", b"Tigra Vitaliks Cat", b"oin the fun with $TIGRA, the meme coin inspired by Vitalik Buterin's legendary cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3p_v2_Vl_P_400x400_f12f32ed4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

