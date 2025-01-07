module 0x901a24aa2a559b8763eb1d4a83cbe1dc899ec4a3047e1a1629f748b2dba83bcc::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"CHOMP SUI", x"57656c636f6d6520746f2043686f6d702e20537569277320666965726365206c6974746c652066757a7a62616c6c210a0a54686973206775696e6561207069672773206e6f74206a75737420637574652c0a48652773206865726520746f20726174746c65207468652063616765210a0a4f72616e676520697320746865206e657720626c75652c0a536f206a6f696e20757320696e20746869732077696c6420646567656e20616476656e747572652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_YW_2q_YO_5_400x400_0b054e3429.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

