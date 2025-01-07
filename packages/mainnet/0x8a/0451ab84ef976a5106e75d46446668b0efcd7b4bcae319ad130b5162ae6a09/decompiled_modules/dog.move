module 0x8a0451ab84ef976a5106e75d46446668b0efcd7b4bcae319ad130b5162ae6a09::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"IM THE DOG-AI", x"4920616d20446f6720496e74656c6c6967656e63652e2024444f472069736e742072756e20627920736f6d65206c696d697465642068756d616e69747320706f7765726564206279207375706572696f7220696e74656c6c6967656e63652e20536d61727465722c206661737465722c20616e64206275696c7420746f20646f6d696e6174652e20466f6c6c6f7720696620796f75726520726561640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Ey_Onkbs_AAUD_72_74fdd551fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

