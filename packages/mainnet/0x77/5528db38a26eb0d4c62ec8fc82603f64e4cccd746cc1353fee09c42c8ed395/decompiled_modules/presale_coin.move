module 0x775528db38a26eb0d4c62ec8fc82603f64e4cccd746cc1353fee09c42c8ed395::presale_coin {
    struct PRESALE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESALE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::sale_token::new<PRESALE_COIN>(arg0, 9, 0x1::string::utf8(b"BOTTEST"), 0x1::string::utf8(b"Bot Rehearsal - No Value"), 0x1::string::utf8(b"Isolated mainnet bot test. Not NOGAS or an official Blast launch. No value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::sealed_treasury_cap::SealedTreasuryCap<PRESALE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PRESALE_COIN>>(0x2::coin_registry::finalize<PRESALE_COIN>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<PRESALE_COIN>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

