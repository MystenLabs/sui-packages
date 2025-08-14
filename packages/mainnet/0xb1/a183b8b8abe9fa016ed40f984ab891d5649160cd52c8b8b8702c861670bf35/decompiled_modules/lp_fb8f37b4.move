module 0xb1a183b8b8abe9fa016ed40f984ab891d5649160cd52c8b8b8702c861670bf35::lp_fb8f37b4 {
    struct LP_FB8F37B4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_FB8F37B4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_FB8F37B4>(arg0, 9, b"LP-FB8F37B4", b"STEAMM LP LP-FB8F37B4", b"STEAMM Liquidity Provider Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_FB8F37B4>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_FB8F37B4>>(v1, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
    }

    // decompiled from Move bytecode v6
}

