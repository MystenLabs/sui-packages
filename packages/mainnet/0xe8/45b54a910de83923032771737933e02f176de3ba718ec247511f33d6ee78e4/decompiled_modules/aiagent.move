module 0xe845b54a910de83923032771737933e02f176de3ba718ec247511f33d6ee78e4::aiagent {
    struct AIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIAGENT>(arg0, 6, b"AIAGENT", b"AI Agent", x"4169204167656e7473206f6e2074686520537569204e6574776f726b2e0a48656c70206f75722070726f647563742067726f772e200a5669736974206f75722077656220706c6174666f726d200a546f6b656e207574696c69747920636f6d696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiaww_495cd8d6ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

