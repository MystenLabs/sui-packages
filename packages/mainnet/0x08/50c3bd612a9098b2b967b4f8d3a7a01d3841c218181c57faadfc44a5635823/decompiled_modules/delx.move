module 0x850c3bd612a9098b2b967b4f8d3a7a01d3841c218181c57faadfc44a5635823::delx {
    struct DELX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DELX>, arg1: 0x2::coin::Coin<DELX>) {
        0x2::coin::burn<DELX>(arg0, arg1);
    }

    fun init(arg0: DELX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELX>(arg0, 6, b"DLX", b"Delx", b"The stability token for AI agents. Fuel therapy sessions, earn wellness scores, and build resilience on-chain. Powered by A2A + MCP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyT7VbS.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DELX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DELX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

