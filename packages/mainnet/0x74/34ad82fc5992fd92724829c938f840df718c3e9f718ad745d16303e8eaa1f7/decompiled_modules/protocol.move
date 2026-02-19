module 0x7434ad82fc5992fd92724829c938f840df718c3e9f718ad745d16303e8eaa1f7::protocol {
    struct PROTOCOL has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL>, arg1: 0x2::coin::Coin<PROTOCOL>) {
        0x2::coin::burn<PROTOCOL>(arg0, arg1);
    }

    public fun handle(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL> {
        0x2::coin::mint<PROTOCOL>(arg0, arg1, arg2)
    }

    public entry fun handle_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL>>(0x2::coin::mint<PROTOCOL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL>(arg0, 9, b"suiUSDe", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-dP2IrNw8zp.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

