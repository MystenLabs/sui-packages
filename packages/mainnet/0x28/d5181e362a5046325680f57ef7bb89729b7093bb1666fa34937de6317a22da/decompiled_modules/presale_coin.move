module 0x28d5181e362a5046325680f57ef7bb89729b7093bb1666fa34937de6317a22da::presale_coin {
    struct PRESALE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESALE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::sale_token::new<PRESALE_COIN>(arg0, 9, 0x1::string::utf8(b"PAR10"), 0x1::string::utf8(b"Parallel Timing Test - No Value"), 0x1::string::utf8(b"Isolated mainnet bot test. Not NOGAS or an official Blast launch. No value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::sealed_treasury_cap::SealedTreasuryCap<PRESALE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PRESALE_COIN>>(0x2::coin_registry::finalize<PRESALE_COIN>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<PRESALE_COIN>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

