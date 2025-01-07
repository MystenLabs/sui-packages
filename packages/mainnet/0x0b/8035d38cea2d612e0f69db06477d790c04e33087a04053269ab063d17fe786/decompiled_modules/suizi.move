module 0xb8035d38cea2d612e0f69db06477d790c04e33087a04053269ab063d17fe786::suizi {
    struct SUIZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZI>(arg0, 6, b"SUIZI", b"Suizi the owl", x"436865657220666f722066756e2077697468206e6f20656d6f74696f6e73206f6e20537569206c696b652061206d616e696163210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_M_Jmj9_y_400x400_0cbca5d249.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

