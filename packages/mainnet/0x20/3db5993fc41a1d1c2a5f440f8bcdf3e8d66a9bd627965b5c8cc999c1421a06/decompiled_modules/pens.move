module 0x203db5993fc41a1d1c2a5f440f8bcdf3e8d66a9bd627965b5c8cc999c1421a06::pens {
    struct PENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENS>(arg0, 6, b"PENS", b"PENISFISH", x"4a75737420612062756c6c6973682c206c6f6e672c206861726420616e64206572656374696c6520666973682e205570646174656420666f722058285477697474657229206c696e6b2e200a0a2d4e6f207275672c206a757374206d6f6f6e2e200a2d5765627369746520616e642054656c656772616d206c696e6b7320402032306b204d4341500a2d537461792068617264202763617573652050656e69736669736820697320616c7761797320686172642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PENISFISHLFG_2_5f8662392e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

