module 0x145f11669a5db66fb525d596ef4bb329505fbccfbc2339534499915d6b17b4cb::lp_91d98598 {
    struct LP_91D98598 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_91D98598, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_91D98598>(arg0, 9, b"LP-91D98598", b"STEAMM LP LP-91D98598", b"STEAMM Liquidity Provider Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_91D98598>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_91D98598>>(v1, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
    }

    // decompiled from Move bytecode v6
}

