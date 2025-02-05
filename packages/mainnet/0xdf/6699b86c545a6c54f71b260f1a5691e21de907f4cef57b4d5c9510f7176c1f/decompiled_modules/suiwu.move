module 0xdf6699b86c545a6c54f71b260f1a5691e21de907f4cef57b4d5c9510f7176c1f::suiwu {
    struct SUIWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWU>(arg0, 6, b"SUIWU", b"Suiwu", x"5375697775202d20746865206d656d65636f696e2074686174732061732063757465206173206974206973206368616f7469632e200a0a506f776572656420627920616e696d6520766962657320616e642070757265206d656d65206d616769632c205375697775206973206865726520746f20737465616c20796f75722068656172742028616e6420796f757220535549292e200a0a47657420726561647920746f2055777520796f75722077617920746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017440_0ac8cb70c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

