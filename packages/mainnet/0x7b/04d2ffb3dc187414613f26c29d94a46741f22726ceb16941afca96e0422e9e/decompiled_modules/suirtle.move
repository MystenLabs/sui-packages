module 0x7b04d2ffb3dc187414613f26c29d94a46741f22726ceb16941afca96e0422e9e::suirtle {
    struct SUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRTLE>(arg0, 6, b"SUIRTLE", b"SUI TURTLE", x"2453554952544c45206272696e677320746865206368696c6c2076696265732c2070726f6d6973696e672061206c6569737572656c7920636c696d6220746f2074686520746f702c20746865207261636520697320736c6f7720616e64207374656164792e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/turtle_b35b5a2a91.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

