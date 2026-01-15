module 0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui {
    struct USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDSUI>(arg0, 6, 0x1::string::utf8(b"USDSUI"), 0x1::string::utf8(b"USDsui"), 0x1::string::utf8(b"USDsui is Sui's native, USD-backed stablecoin, issued via Bridge's Open Issuance platform and built for regulatory compliance. It powers payments, DeFi, and on-chain commerce across the Sui ecosystem, while seamlessly interoperating with other Bridge-issued stablecoins to enable global liquidity."), 0x1::string::utf8(b"https://token-metadata-phi.vercel.app/images/usdsui.png"), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<USDSUI>>(0x2::coin_registry::finalize<USDSUI>(v2, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDSUI>>(0x2::coin_registry::make_regulated<USDSUI>(&mut v2, true, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

