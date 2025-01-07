module 0x12ec678473a5b5b91b9c4b44f6b61d36a5568de3dbaf9733c6e11f27cb7f47d4::rusty {
    struct RUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSTY>(arg0, 6, b"RUSTY", b"Rusty The Racoon", b"He is a mischievous racoon based on sui, lets help him together so he can get off his addiction of taking other racoons vegetables and fruits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_035796aeca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

