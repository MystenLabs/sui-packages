module 0x505d682404b8ebe0851479846eca8b47d3ad069464ee87a5d863c9311292860e::sheets {
    struct SHEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEETS>(arg0, 9, b"SHEETS", b"Sui Sheets", b"Sui Sheets Viral X Trend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8ck3Bcgmj2UX4zPGtuHJoqj69iJitpfuF45FR547pump.png?size=lg&key=dce2d7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHEETS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEETS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

