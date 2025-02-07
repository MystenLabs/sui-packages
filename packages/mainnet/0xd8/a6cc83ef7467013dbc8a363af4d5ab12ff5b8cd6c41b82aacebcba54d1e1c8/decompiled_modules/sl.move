module 0xd8a6cc83ef7467013dbc8a363af4d5ab12ff5b8cd6c41b82aacebcba54d1e1c8::sl {
    struct SL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SL>(arg0, 6, b"SL", b"SuiLobster", b"Introducing SuiLobster, the meme coin thats snapping up the crypto world, one claw at a time! Built on the ultra-fast and secure Sui Network, SuiLobster combines the power of blockchain tech with the boldness of your favorite crustacean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Lobster_Main_profile_pic_9f2a83e888.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SL>>(v1);
    }

    // decompiled from Move bytecode v6
}

