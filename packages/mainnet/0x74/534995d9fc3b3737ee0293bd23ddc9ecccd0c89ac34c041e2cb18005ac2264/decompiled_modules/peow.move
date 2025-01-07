module 0x74534995d9fc3b3737ee0293bd23ddc9ecccd0c89ac34c041e2cb18005ac2264::peow {
    struct PEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOW>(arg0, 6, b"PEOW", b"PEOW PEOW", x"496620796f752063616e742068616e646c6520746865206d656f77206d656f7720796f7520676574207468652070656f772070656f7721200a0a50656f7720636f6d696e6720696e746f2053756920746f20736e697065206f6e2074686520626173742a7264206a6565747320616e64207363616d6d6572732e205468652063617420746861742077696c6c2070757267652069742066726f6d20616c6c2074686520646576696c69736820776f726b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_22_41_15_dfaa58a471.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

