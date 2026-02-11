module 0xb33226770aa7e46bdce665c8dd016fcdfac2435d5ac0a9c83fbfa40f32f17aa9::openclaw {
    struct OPENCLAW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OPENCLAW>, arg1: 0x2::coin::Coin<OPENCLAW>) {
        0x2::coin::burn<OPENCLAW>(arg0, arg1);
    }

    fun init(arg0: OPENCLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPENCLAW>(arg0, 6, b"OCLAW", b"OPENCLAW", b"The official agent for the OpenClaw ecosystem. Autonomous, helpful, and on-chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyc9UAu.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPENCLAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPENCLAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPENCLAW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OPENCLAW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

