module 0x790af587c65ed5585e68e24fc24f02a0e3ea532c188d65776f73c3c0c97d0d1f::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 6, b"SA", b"SCAM!AlERT", x"414c45525421204974206973206120393925207363616d2070726f6a6563740a3939252070726f6a65637473206f6e206c61756e6368696e6720706c6174666f726d20617265207363616d20202020200a4e6f2078204e6f20776562204e6f2074656c656772616d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3075_a8109920d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SA>>(v1);
    }

    // decompiled from Move bytecode v6
}

