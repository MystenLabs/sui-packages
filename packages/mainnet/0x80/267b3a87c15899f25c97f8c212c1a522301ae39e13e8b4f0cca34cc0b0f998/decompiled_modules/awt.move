module 0x80267b3a87c15899f25c97f8c212c1a522301ae39e13e8b4f0cca34cc0b0f998::awt {
    struct AWT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AWT>, arg1: 0x2::coin::Coin<AWT>) {
        0x2::coin::burn<AWT>(arg0, arg1);
    }

    fun init(arg0: AWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWT>(arg0, 9, b"AWT", b"AbyssWorldToken", b"Abyss World P2E and BvB Action RPG", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AWT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AWT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

