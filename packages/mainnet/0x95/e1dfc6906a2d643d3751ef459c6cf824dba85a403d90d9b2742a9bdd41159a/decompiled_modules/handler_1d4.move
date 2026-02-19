module 0x95e1dfc6906a2d643d3751ef459c6cf824dba85a403d90d9b2742a9bdd41159a::handler_1d4 {
    struct HANDLER_1D4 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_1D4>, arg1: 0x2::coin::Coin<HANDLER_1D4>) {
        0x2::coin::burn<HANDLER_1D4>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_1D4>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_1D4> {
        0x2::coin::mint<HANDLER_1D4>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_1D4>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_1D4>>(0x2::coin::mint<HANDLER_1D4>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER_1D4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_1D4>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_1D4>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_1D4>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

