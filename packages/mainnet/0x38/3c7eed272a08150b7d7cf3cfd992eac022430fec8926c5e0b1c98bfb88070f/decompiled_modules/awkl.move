module 0x383c7eed272a08150b7d7cf3cfd992eac022430fec8926c5e0b1c98bfb88070f::awkl {
    struct AWKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWKL>(arg0, 6, b"AWKL", b"Akward Moment Seal", x"496e74726f647563696e672041574b4c202d20746865206d656d6520636f696e2074686174207475726e73206c6966652773206d6f7374206372696e67652d776f72746879206d6f6d656e747320696e746f2063727970746f20776f726c642e0a0a456d6272616365207468652041776b776172642e20484f444c20746865205365616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_QU_5q_Ngkw_T3_Q_Vg_ED_iar2_A_wide_8540fedf2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

