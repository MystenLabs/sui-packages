module 0x63577313f1c08715113563b4f1ccc25be2eb3ceb98e8e6b502236f46f6eec90::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"Illegal", b"Hey @suilaunchcoin $ICE  + Illegal Crypto Enforcement https://t.co/K21TV6tbaF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ice-qv0wje.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

