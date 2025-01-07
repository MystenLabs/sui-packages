module 0xaf473ca6076c49ffd669a6acc60a470fe6cca898ebdd292d66667b94d11a2c97::ubiquitous {
    struct UBIQUITOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBIQUITOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBIQUITOUS>(arg0, 9, b"UBIQUITOUS", b"ubiquitous", b"omni-presence-life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6y7S5kvWjBBVaofHFCa147nvdBgyYSghiP5weS43pump.png?size=xl&key=c7069d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UBIQUITOUS>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBIQUITOUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBIQUITOUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

