module 0x8c47363c0872ae1c2a1f800e1cacefc80b081703df1e6ecbe3101a00ab292d51::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDO>, arg1: 0x2::coin::Coin<SUIDO>) {
        0x2::coin::burn<SUIDO>(arg0, arg1);
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"SuidoWoodo", b"Woodo woodo, woodo woodo. WOODO WOODO!!!!, Woodo Woodo!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

