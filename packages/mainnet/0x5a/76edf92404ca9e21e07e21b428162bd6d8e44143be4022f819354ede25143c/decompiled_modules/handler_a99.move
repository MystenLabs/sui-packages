module 0x5a76edf92404ca9e21e07e21b428162bd6d8e44143be4022f819354ede25143c::handler_a99 {
    struct HANDLER_A99 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_A99>, arg1: 0x2::coin::Coin<HANDLER_A99>) {
        0x2::coin::burn<HANDLER_A99>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_A99>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_A99> {
        0x2::coin::mint<HANDLER_A99>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_A99>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_A99>>(0x2::coin::mint<HANDLER_A99>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER_A99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_A99>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_A99>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_A99>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

