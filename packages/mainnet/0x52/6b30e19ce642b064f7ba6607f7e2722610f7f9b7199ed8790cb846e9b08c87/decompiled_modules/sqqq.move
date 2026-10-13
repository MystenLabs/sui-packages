module 0x526b30e19ce642b064f7ba6607f7e2722610f7f9b7199ed8790cb846e9b08c87::sqqq {
    struct SQQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SQQQ>(arg0, 8, 0x1::string::utf8(b"sQQQ"), 0x1::string::utf8(b"Invesco QQQ xSpot"), 0x1::string::utf8(b"One coin per Invesco QQQ xStock (QQQx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the QQQx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/qqq.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQQQ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SQQQ>>(0x2::coin_registry::finalize<SQQQ>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

