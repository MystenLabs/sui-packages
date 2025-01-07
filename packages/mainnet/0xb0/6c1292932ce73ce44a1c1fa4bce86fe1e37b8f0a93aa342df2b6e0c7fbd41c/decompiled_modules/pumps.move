module 0xb06c1292932ce73ce44a1c1fa4bce86fe1e37b8f0a93aa342df2b6e0c7fbd41c::pumps {
    struct PUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPS>(arg0, 6, b"PUMPS", b"PUMPSUI", b"pumpismsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wg8_YG_5p_W8i7_ABKGF_25_HB_Mq_Dz9_Mrs15jwvwy_B8nnpump_69ca721e1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

