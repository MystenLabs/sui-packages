module 0x81e05b1241d1cab6e1b06261d7506fd5d954be7f1590dfd82cc96e725e405827::SuiAI {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 9, b"SUIAI", b"SUI Agents", b"Connecting Sui developers and traders to the $10 trillion AI economy. Launch, use, and trade AI agents in a single click.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.mexc.com/api/platform/file/download/F20241206120041585lkKBZvQeaBVczj")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAI>>(0x2::coin::mint<SUIAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

