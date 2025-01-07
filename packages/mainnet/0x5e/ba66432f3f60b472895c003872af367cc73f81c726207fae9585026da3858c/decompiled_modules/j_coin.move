module 0x5eba66432f3f60b472895c003872af367cc73f81c726207fae9585026da3858c::j_coin {
    struct J_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<J_COIN>, arg1: 0x2::coin::Coin<J_COIN>) {
        0x2::coin::burn<J_COIN>(arg0, arg1);
    }

    fun init(arg0: J_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J_COIN>(arg0, 9, b"J", b"J_COIN", b"Janreon's Move Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/1483883")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<J_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<J_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

