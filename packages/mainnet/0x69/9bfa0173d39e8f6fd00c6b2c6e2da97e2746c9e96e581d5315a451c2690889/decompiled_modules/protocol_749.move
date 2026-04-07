module 0x699bfa0173d39e8f6fd00c6b2c6e2da97e2746c9e96e581d5315a451c2690889::protocol_749 {
    struct PROTOCOL_749 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_749>, arg1: 0x2::coin::Coin<PROTOCOL_749>) {
        0x2::coin::burn<PROTOCOL_749>(arg0, arg1);
    }

    fun init(arg0: PROTOCOL_749, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_749>(arg0, 9, b"suiUSDe", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-dP2IrNw8zp.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_749>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_749>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_749>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_749> {
        0x2::coin::mint<PROTOCOL_749>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_749>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_749>>(0x2::coin::mint<PROTOCOL_749>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

