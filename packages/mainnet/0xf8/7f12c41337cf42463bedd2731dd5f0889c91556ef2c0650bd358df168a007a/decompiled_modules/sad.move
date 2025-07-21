module 0xf87f12c41337cf42463bedd2731dd5f0889c91556ef2c0650bd358df168a007a::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"sad", b"@suilaunchcoin  Launch a project on @suilaunchcoin by tagging @Pokemon and including the project name and logo. $sad + sad silliont", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sad-7kngwh.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

