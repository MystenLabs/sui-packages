module 0x9a21c80104da78d4eceabf890bb1e3f60d652d0fbb0d2ae47d9ef816c97db98c::sir3_coin {
    struct SIR3_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIR3_COIN>, arg1: 0x2::coin::Coin<SIR3_COIN>) {
        0x2::coin::burn<SIR3_COIN>(arg0, arg1);
    }

    fun init(arg0: SIR3_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR3_COIN>(arg0, 9, b"SIR3", b"SRI3.L", b"SUI TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/benjabbbb/default/refs/heads/main/28b17219.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIR3_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIR3_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIR3_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIR3_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

