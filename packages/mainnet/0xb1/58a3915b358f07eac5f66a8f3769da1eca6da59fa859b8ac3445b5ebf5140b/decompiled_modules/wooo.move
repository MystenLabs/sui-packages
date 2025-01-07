module 0xb158a3915b358f07eac5f66a8f3769da1eca6da59fa859b8ac3445b5ebf5140b::wooo {
    struct WOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOO>(arg0, 6, b"WOOO", b"WOOOO", x"546865205374796c696e272c2070726f66696c696e272c206c696d6f7573696e6520726964696e672c206a657420666c79696e672c206b6973732d737465616c696e672c20776865656c696e27206e27206465616c696e2720736f6e206f6620612067756e210a496620796f7520646f6e2774206c696b652069742c206c6561726e20746f202a6c6f76652a2069742120574f4f4f2121212057452057494c4c20444f204e554d42455253204c494b45204e45564552204245464f52452e434f4d4d554e4954592057494c4c204255494c4420574f4f4f204d494c4c494f4e41495245532e57454c434f4d452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6295_aef806f010.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

