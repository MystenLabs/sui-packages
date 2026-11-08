module 0x741245fdbdd2e07a6578c488d8308d2c4e4b4e6315944a0b42f988c25107ef61::presale_coin {
    struct PRESALE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESALE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x46f43834ce4ea917d3a3dcecc5418170cc516739ebe91425533374ef94bbd540::sale_token::new<PRESALE_COIN>(arg0, 9, 0x1::string::utf8(b"BCPS"), 0x1::string::utf8(b"Blast Rehearsal BCPS"), 0x1::string::utf8(b"Blast TEST_SUI rehearsal"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap::SealedTreasuryCap<PRESALE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        if (true) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PRESALE_COIN>>(0x2::coin_registry::finalize<PRESALE_COIN>(v0, arg1), @0xef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<PRESALE_COIN>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

