module 0x9a1da065d90a12d90ce2160cddb025d9fcdb1152f2e4b647239713f182c612d5::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"Illegal", b"Hey @suilaunchcoin $ICE  + Illegal Crypto Enforcement https://t.co/glxPeWCj7j", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ice-wylb3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

