module 0x2370610f12bd4b3dd3a359c85811f3e58194e66cf39d825d77fddb2f23b8f86b::spotty {
    struct SPOTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTTY>(arg0, 6, b"SPOTTY", b"Spotty", x"53706f747479202d20447261776e20627920506176656c204475726f7620696e2032303130206f6e2068697320323674682062697274686461792053706f74747920776173206372656174656420746f206265207468652066616365206f66205275737369616e20536f6369616c204d6564696120706c6174666f726d20566b6f6e74616b746520616e6420506176656c73206661766f7269746520616e7461676f6e6973742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vq_Zej_Td_B_400x400_b32a911a8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

