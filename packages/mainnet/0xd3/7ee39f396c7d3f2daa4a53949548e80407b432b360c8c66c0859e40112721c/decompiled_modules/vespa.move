module 0xd37ee39f396c7d3f2daa4a53949548e80407b432b360c8c66c0859e40112721c::vespa {
    struct VESPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VESPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VESPA>(arg0, 6, b"VESPA", b"Sui Vespa", x"5269646520746865207761766573206f662053756920696e207374796c652e20466173742c20736c65656b2c20616e6420726561647920666f7220612077696c6420726964652e0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vespa_7d151b34c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VESPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VESPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

