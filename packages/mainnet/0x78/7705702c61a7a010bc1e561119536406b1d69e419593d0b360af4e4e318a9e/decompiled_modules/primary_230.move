module 0x787705702c61a7a010bc1e561119536406b1d69e419593d0b360af4e4e318a9e::primary_230 {
    struct PRIMARY_230 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_230>, arg1: 0x2::coin::Coin<PRIMARY_230>) {
        0x2::coin::burn<PRIMARY_230>(arg0, arg1);
    }

    fun init(arg0: PRIMARY_230, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY_230>(arg0, 9, b"veHAEDAL", b"Haedal Protocol", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-6SJZ3wK7nF.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY_230>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY_230>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_230>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY_230> {
        0x2::coin::mint<PRIMARY_230>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_230>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY_230>>(0x2::coin::mint<PRIMARY_230>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

