module 0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5 {
    struct SUIX5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX5>(arg0, 6, b"SUIX5", b"SuiX5", b"Autonomous passive index tracking the top 5 Sui ecosystem tokens by market cap, capped at 40% per constituent. Eligibility requires a live on-chain price feed. sui-x.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://indigo-elaborate-bovid-600.mypinata.cloud/ipfs/bafkreih4dle5txwovr6nkwmqx3nkq364e6g46yhvbfgzgg733fbvmizcwe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX5>>(v0, @0xbe8717541bbc087df0319ba4f00d24d88db8efe795f6c6bf899514756f5be016);
    }

    // decompiled from Move bytecode v7
}

