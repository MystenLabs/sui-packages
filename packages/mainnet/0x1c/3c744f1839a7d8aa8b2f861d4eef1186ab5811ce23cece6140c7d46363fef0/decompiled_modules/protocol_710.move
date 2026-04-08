module 0x1c3c744f1839a7d8aa8b2f861d4eef1186ab5811ce23cece6140c7d46363fef0::protocol_710 {
    struct PROTOCOL_710 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_710>, arg1: 0x2::coin::Coin<PROTOCOL_710>) {
        0x2::coin::burn<PROTOCOL_710>(arg0, arg1);
    }

    fun init(arg0: PROTOCOL_710, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_710>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-qSX-pvoR06.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_710>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_710>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_710>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_710> {
        0x2::coin::mint<PROTOCOL_710>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_710>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_710>>(0x2::coin::mint<PROTOCOL_710>(arg0, arg1, arg3), arg2);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

