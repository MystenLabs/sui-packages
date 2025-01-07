module 0x6ee11115c80562f3153c8f8b279954532c98d3ddccbea499aa8256712a0e5336::xrpc {
    struct XRPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRPC>(arg0, 6, b"XRPC", b"Ripple Classic", x"524950504c4520434c4153534943202d202458525043200a42652070617274206f66207468652058525020436c617373696320636f6d6d756e6974792c2073686170696e672074686520667574757265206f6620676c6f62616c207061796d656e74732e20546f6765746865722c206c65742773206372656174652061206d6f726520636f6e6e65637465642c20657175697461626c652c20616e642070726f737065726f757320776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050697_8c4f698646.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

