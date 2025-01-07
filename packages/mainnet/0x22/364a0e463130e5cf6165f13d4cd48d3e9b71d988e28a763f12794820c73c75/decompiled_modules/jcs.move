module 0x22364a0e463130e5cf6165f13d4cd48d3e9b71d988e28a763f12794820c73c75::jcs {
    struct JCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCS>(arg0, 6, b"JCS", b"Jumping Cat Sui", b"Welcome to Jumping Cat Token!  Let's help groups of cats dance more, spread joy, and support meaningful causes!  Join the fun, buy now, and be part of the purr-fect movement! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_bbbeec2016.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

