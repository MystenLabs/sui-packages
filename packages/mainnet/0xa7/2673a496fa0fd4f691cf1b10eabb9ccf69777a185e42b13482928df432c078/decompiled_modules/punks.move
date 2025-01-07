module 0xa72673a496fa0fd4f691cf1b10eabb9ccf69777a185e42b13482928df432c078::punks {
    struct PUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKS>(arg0, 6, b"Punks", b"theSuiPunks", x"33393933202353756950756e6b73205046507320746861742070726f766520796f7527726520746865204561726c79204d656d626572206f6620537569746865204669727374204e465420636f6c6c656374696f6e206f6e200a405375694e6574776f726b0a207c20245350554e4b20235350554e4b746f314d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/punk_4bdaef3103.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

