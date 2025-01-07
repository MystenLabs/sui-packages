module 0x16447192c26846000fb5f96854c5994c6d32f515b4e2ac3e58d881e07b1bd559::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOON>(arg0, 6, b"GOON", b"GoonAI.meme", x"476f6f6e20776974682074686520706f776572206f662041492e20476f20746f206f7572207765627369746520746f2075736520414920746f2067656e657261746520696d6167657320616e6420676f6f6e20746f20766172696f757320636861726163746572732121210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CI_5_MR_Dc_400x400_03442c3b13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

