module 0xa12e75ea649d3d82b47cc265fe6d3466b2a2e656b03226233f1c1fc8dd7a74da::suirabbit {
    struct SUIRABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRABBIT>(arg0, 6, b"SUIRABBIT", b"RABBIT", b"THE AMAZING RABBIT OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_13_010407591_4d04db9a27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

