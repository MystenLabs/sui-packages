module 0x5dcd6dbd582d1d3088800360cc4fb9250c0ed827e6a45e833e32708f23d86f0e::handler {
    struct HANDLER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER>, arg1: 0x2::coin::Coin<HANDLER>) {
        0x2::coin::burn<HANDLER>(arg0, arg1);
    }

    fun init(arg0: HANDLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER>(arg0, 9, b"suiUSDe", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-OZUUe_vwpS.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<HANDLER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER> {
        0x2::coin::mint<HANDLER>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER>>(0x2::coin::mint<HANDLER>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

