module 0x3b9a00cb6d3757ae1d75ae1d3407d78b4bdd33ab70317b0abf27a5b579a1263a::seahorse {
    struct SEAHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAHORSE>(arg0, 6, b"SEAHORSE", b"Sam The Seahorse", x"53616d206973206b696e64206f6620612073687920736561686f7273652c206865206973206865726520746f206d616b6520736f6d65206672656e732c20616e64206275696c64206120636f6d6d756e69747920736f2068652063616e2066756c6c66696c6c2068697320647265616d206f66206265696e6720746865204b696e67204f6620546865205365612e0a0a436f6d65206a6f696e2068697320746720616e6420676f20746f20746865206d6f6f6e20776974682068696d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_8186a49e35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

