module 0xe4d37705d385d5b4b9ce6c7d2d9a0b04480a21114913e1ba85d5fcb90f51c085::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOT>(arg0, 6, b"BOT", b"ROBOT", b"@SuiAIFun @suilaunchcoin @suilaunchcoin $BOT + ROBOT  We invaded by the ai robots beep beep boop https://t.co/oeZuMlMHxl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bot-5x6wff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

