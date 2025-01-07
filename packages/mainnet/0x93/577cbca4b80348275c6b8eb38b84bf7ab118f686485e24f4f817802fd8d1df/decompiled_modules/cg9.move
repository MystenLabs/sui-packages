module 0x93577cbca4b80348275c6b8eb38b84bf7ab118f686485e24f4f817802fd8d1df::cg9 {
    struct CG9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CG9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CG9>(arg0, 6, b"CG9", b"Crypto Gains", x"43727970746f204761696e73204d656d652c2031302c3030302c3030302c30303020546f74616c20537570706c792c2044657820436f6d696e6721202043726561746f722035250a0a5468616e6b732c20456e6a6f7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053056_712d00616a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CG9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CG9>>(v1);
    }

    // decompiled from Move bytecode v6
}

