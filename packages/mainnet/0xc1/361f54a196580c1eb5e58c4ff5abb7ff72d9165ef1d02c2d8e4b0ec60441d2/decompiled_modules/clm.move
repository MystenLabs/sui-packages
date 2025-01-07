module 0xc1361f54a196580c1eb5e58c4ff5abb7ff72d9165ef1d02c2d8e4b0ec60441d2::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 6, b"CLM", b"CALM", x"4920627265617468652c20636c69636b20616e642063616c6d20646f776e2e4920627265617468652c20636c69636b20616e642063616c6d20646f776e2e4920627265617468652c20636c69636b20616e642063616c6d20646f776e2e0a212041742074686520656e64206f6620697420616c6c20492077696c6c20736d696c6521200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d18da0e4_6f42_461e_95e1_f76cf894f79f_754x394_08e5184785.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

