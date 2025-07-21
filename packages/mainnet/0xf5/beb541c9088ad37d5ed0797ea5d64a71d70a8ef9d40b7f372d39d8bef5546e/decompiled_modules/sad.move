module 0xf5beb541c9088ad37d5ed0797ea5d64a71d70a8ef9d40b7f372d39d8bef5546e::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"sad", b"@suilaunchcoin @SuiAIFun  @suilaunchcoin $sad +sad silliont https://t.co/wDYz3ow3SV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sad-lab0zp.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

