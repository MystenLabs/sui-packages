module 0xee6d3530f367b979ff14f95a4e5f0ccc0b0d0b6a56832473da97df9ac23aa2d::steamm_lp_bsuinator_bwusdc {
    struct STEAMM_LP_BSUINATOR_BWUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUINATOR_BWUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUINATOR_BWUSDC>(arg0, 9, b"STEAMM LP bSUINATOR-bwUSDC", b"STEAMM LP Token bSUINATOR-bwUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUINATOR_BWUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUINATOR_BWUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

