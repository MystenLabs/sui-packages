module 0x2379e7c1f7a2e6e790dc9583c6299382494e2e47f31f47ce473f464c84bee295::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"Wen Jet Suit", x"57656e204a6574205375697420697320746865206669727374206d656d65636f696e20746f206c657665726167652064656669207969656c647320696e746f20612073656c662d7375737461696e696e6720666c79776865656c2e2020416c6c20706f73747320616e6420636f6e74656e7420617265206e6f742066696e616e6369616c206164766963652120205450502c205741474d49204c4946450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MS_Aw_OG_Aa_400x400_2246dcfbac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

