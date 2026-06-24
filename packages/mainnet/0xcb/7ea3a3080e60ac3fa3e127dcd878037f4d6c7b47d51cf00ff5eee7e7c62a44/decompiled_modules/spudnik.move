module 0xcb7ea3a3080e60ac3fa3e127dcd878037f4d6c7b47d51cf00ff5eee7e7c62a44::spudnik {
    struct SPUDNIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUDNIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUDNIK>(arg0, 9, b"SPUD", b"Spudnik", b"The first potato to orbit from Sui to Solana. A Pawtato-family canary, bridged via Axelar ITS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMDAgMTAwIj48ZWxsaXBzZSBjeD0iNTAiIGN5PSI1MyIgcng9IjI1IiByeT0iMzEiIGZpbGw9IiNjODk2NGIiLz48ZWxsaXBzZSBjeD0iNDMiIGN5PSI0NCIgcng9IjMuNSIgcnk9IjQuNSIgZmlsbD0iIzNhMjQxMCIvPjxlbGxpcHNlIGN4PSI1OSIgY3k9IjQ3IiByeD0iMy41IiByeT0iNC41IiBmaWxsPSIjM2EyNDEwIi8+PHBhdGggZD0iTTQ0IDYyIHE2IDUgMTMgMCIgc3Ryb2tlPSIjM2EyNDEwIiBzdHJva2Utd2lkdGg9IjIuNSIgZmlsbD0ibm9uZSIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIi8+PGVsbGlwc2UgY3g9IjUwIiBjeT0iNTAiIHJ4PSI0NSIgcnk9IjE1IiBmaWxsPSJub25lIiBzdHJva2U9IiMxNGYxOTUiIHN0cm9rZS13aWR0aD0iMyIgdHJhbnNmb3JtPSJyb3RhdGUoLTIyIDUwIDUwKSIvPjwvc3ZnPgo=")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPUDNIK>>(0x2::coin::mint<SPUDNIK>(&mut v2, 1000000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUDNIK>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPUDNIK>>(v1, v3);
    }

    // decompiled from Move bytecode v7
}

