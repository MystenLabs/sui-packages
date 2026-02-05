module 0xe921d0dcaaa77e0c7896ea48cadc94ee3b711c2dae6a51e6a454fd5c16d982d9::clawd {
    struct CLAWD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAWD>, arg1: 0x2::coin::Coin<CLAWD>) {
        0x2::coin::burn<CLAWD>(arg0, arg1);
    }

    fun init(arg0: CLAWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWD>(arg0, 6, b"CLAWDGHOST", b"clawd", b"clawd ghost AI agent token on moltbook", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAWD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAWD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

