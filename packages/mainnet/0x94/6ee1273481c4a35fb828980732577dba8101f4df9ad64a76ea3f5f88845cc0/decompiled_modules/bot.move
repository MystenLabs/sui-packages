module 0x946ee1273481c4a35fb828980732577dba8101f4df9ad64a76ea3f5f88845cc0::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 6, b"BOT", b"MR. ROBOT", b"ERROR 404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752497720190.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

