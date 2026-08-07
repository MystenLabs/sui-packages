module 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::suix5 {
    struct SUIX5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX5>(arg0, 6, b"SUIX5", b"SuiX5", b"Autonomous passive index tracking the top 5 Sui ecosystem tokens by market cap, capped at 40% per constituent. Eligibility requires a live Pyth price feed. USDC denominated. sui-x.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://indigo-elaborate-bovid-600.mypinata.cloud/ipfs/bafkreih4dle5txwovr6nkwmqx3nkq364e6g46yhvbfgzgg733fbvmizcwe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

