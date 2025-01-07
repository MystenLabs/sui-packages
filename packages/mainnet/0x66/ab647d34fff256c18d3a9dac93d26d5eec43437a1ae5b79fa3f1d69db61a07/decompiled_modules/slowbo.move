module 0x66ab647d34fff256c18d3a9dac93d26d5eec43437a1ae5b79fa3f1d69db61a07::slowbo {
    struct SLOWBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOWBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOWBO>(arg0, 6, b"SlowBo", b"BoJo", b" BoJo the cronie puppet  wallets can pull strings who will follow yor buys. whofollows my buying tools on sui aimum?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bojo_the_clown_elfi_1b914ad8ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOWBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOWBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

