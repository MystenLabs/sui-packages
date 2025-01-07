module 0xc780adc440e8a8137ea186b2fc157cca1464edae4f576830d3b7e07bd72380ff::plonky {
    struct PLONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLONKY>(arg0, 6, b"PLONKY", b"PlonkySui", b"Were weird, were Plonky.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_050123623_0debe27dd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

