module 0xd6f97c7561c6f4fbef10800fa588cba7e1fc6fc780314cf56e675b9cd7baf891::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"SuiLaunch", b"@suilaunchcoin $HEHE + SuiLaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hehe-otmk02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEHE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

