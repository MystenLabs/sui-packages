module 0x36a89f41eace0006ac47eb4917be93b44ac61116a6d7774aec96babadbac2c6a::lp_0ba5c375 {
    struct LP_0BA5C375 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_0BA5C375, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_0BA5C375>(arg0, 9, b"LP-0BA5C375", b"STEAMM LP LP-0BA5C375", b"STEAMM Liquidity Provider Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_0BA5C375>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_0BA5C375>>(v1, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
    }

    // decompiled from Move bytecode v6
}

