module 0x92c15ae2e9b43ff5ee8d2733b72c203a401205bf7acb8ac3dd01e8fc97fa3a6f::tst2042 {
    struct TST2042 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST2042, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST2042>(arg0, 9, b"TST2042", b"Test TST2042 DO NOT BUY", b"self-launch snipe test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST2042>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST2042>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

