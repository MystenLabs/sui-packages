module 0x67d1b1afa798cd6b46d8d7fd7d4e6b52884a377605a18aaec147cb37b28f28e1::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 6, b"WSUI", b"Wrapped SUI", b"WSUI is the wrapped version of Sui. Wrapped tokens, like WETH or Wrapped Bitcoin, are tokenized versions of cryptocurrencies that are pegged to the value of the original coin and can be unwrapped at any point. Almost every major blockchain has a wrapped version of its native cryptocurrency like Wrapped BNB, Wrapped AVAX, or Wrapped Fantom. The mechanism of such coins is similar to that of stablecoins. Stablecoins are essentially wrapped USD in the sense that dollar-pegged stablecoins can be redeemed for FIAT dollars at any point. In a similar fashion, WBTC, WETH, and all other wrapped coins can be redeemed for the original asset at any time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_642f6b1e19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

