module 0xcdfb8aea018b63fcafb5a41267739cfd84b1d6690cc56986f4ceca3958e64f2a::protocol_736 {
    struct PROTOCOL_736 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_736>, arg1: 0x2::coin::Coin<PROTOCOL_736>) {
        0x2::coin::burn<PROTOCOL_736>(arg0, arg1);
    }

    fun init(arg0: PROTOCOL_736, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_736>(arg0, 9, b"EMBER", b"Ember Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-6kw_a52AhD.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_736>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_736>>(v1);
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_736>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_736> {
        0x2::coin::mint<PROTOCOL_736>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_736>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_736>>(0x2::coin::mint<PROTOCOL_736>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

