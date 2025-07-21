module 0x2f0aa8325f517f89e88f6976710a1229c009996f267c4bdba91306e63d7b8c50::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"sad", b"@suilaunchcoin @SuiNetwork @SuiFoundation @aixdg_agent @SuiAIFun @tokeninsight_io Launch a project on @suilaunchcoin by tagging @EmanAbio and including the project name and logo. $sad + sad silliont", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sad-qi7330.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

