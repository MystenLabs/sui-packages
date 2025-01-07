module 0xe372ba55366d30bb117e88da33b70bcc48d9043e1028ef7ff426108d5f33b1cc::aaak {
    struct AAAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAK>(arg0, 6, b"AAAK", b"aaa kitten", b"Can't stop, won't stop (raving about Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6729_3f39692e96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

