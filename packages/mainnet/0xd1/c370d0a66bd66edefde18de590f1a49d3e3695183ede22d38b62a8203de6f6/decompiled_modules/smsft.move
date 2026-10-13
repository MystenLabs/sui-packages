module 0xd1c370d0a66bd66edefde18de590f1a49d3e3695183ede22d38b62a8203de6f6::smsft {
    struct SMSFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMSFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SMSFT>(arg0, 8, 0x1::string::utf8(b"sMSFT"), 0x1::string::utf8(b"Microsoft xSpot"), 0x1::string::utf8(b"One coin per Microsoft xStock (MSFTx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the MSFTx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/msft.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMSFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SMSFT>>(0x2::coin_registry::finalize<SMSFT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

