module 0x716788e8401ef305e1c9150796316f917b0b561759ffaa15aac9632edb2510cd::balanced_token {
    struct BALANCED_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BALANCED_TOKEN>, arg1: 0x2::coin::Coin<BALANCED_TOKEN>) {
        0x2::coin::burn<BALANCED_TOKEN>(arg0, arg1);
    }

    fun init(arg0: BALANCED_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALANCED_TOKEN>(arg0, 9, b"BALN", b"Balance Token", b"A governance coin of Balanced", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/balancednetwork/icons/refs/heads/main/tokens/baln.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALANCED_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALANCED_TOKEN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BALANCED_TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BALANCED_TOKEN>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

