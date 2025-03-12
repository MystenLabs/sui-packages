module 0x98694f8486d4bcb29b3eb58ea8d97e8ff4b072e25fba4976cd46e609f3c802a4::operaxxxfaucet {
    struct OPERAXXXFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPERAXXXFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPERAXXXFAUCET>(arg0, 6, b"OPERAXXXFAUCET", b"OPERAXXXFAUCET", b"My first faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPERAXXXFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<OPERAXXXFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

