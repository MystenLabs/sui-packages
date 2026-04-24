module 0x3779c55e8b6f01534d9964793d7d3619b275660dad8dfb59b20365b708509dc3::protocol_a9a {
    struct PROTOCOL_A9A has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_A9A>, arg1: 0x2::coin::Coin<PROTOCOL_A9A>) {
        0x2::coin::burn<PROTOCOL_A9A>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_A9A>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_A9A> {
        0x2::coin::mint<PROTOCOL_A9A>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_A9A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_A9A>>(0x2::coin::mint<PROTOCOL_A9A>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROTOCOL_A9A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_A9A>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_A9A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_A9A>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

