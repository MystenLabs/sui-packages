module 0xd76138b14ae97284cd32ccf45905ffbf32beff06767a188c836017c88dc68228::guap {
    struct GUAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUAP>(arg0, 9, b"GUAP", b"GUAP", b"A large amount of money.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1618990662279389189/7VPWluGc_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUAP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

