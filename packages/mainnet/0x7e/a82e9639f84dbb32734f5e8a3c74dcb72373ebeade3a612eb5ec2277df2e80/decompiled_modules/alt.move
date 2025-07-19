module 0x7ea82e9639f84dbb32734f5e8a3c74dcb72373ebeade3a612eb5ec2277df2e80::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALT>(arg0, 6, b"ALT", b"Alt", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $ALT + Alt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/alt-r78quz.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

