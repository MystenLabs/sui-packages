module 0x7998443a32ba2b2e3338c4bbe89088d089851bbd512acdeb214f306a2b19ae75::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: 0x2::coin::Coin<WATER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WATER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER SUI", b"WATER", x"47616d69666965642d6561726e696e672070726f746f636f6c206f6e205355492e20f09f92a720202068747470733a2f2f77617465726e6f64652e696f2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-shocked-dinosaur-182.mypinata.cloud/ipfs/QmdYtiefv9Ud5Twzdu5rmy1nUbWCduL4hR2XGihPwtK2Zj")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: 0x2::coin::Coin<WATER>) : u64 {
        0x2::coin::burn<WATER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WATER> {
        0x2::coin::mint<WATER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

