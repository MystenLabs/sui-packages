module 0xdbde080f8a253e86cec319f3d6733cbd83843776704f9af165b56bcf979ab4f2::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 6, b"FIRE", b"#Palisades Fire", b"#PalisadeFire is a blazing-hot meme coin inspired by the first environmental disaster in 2025. It is fuelled by fiery memes and a passion for decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rai_RF_4hw_400x400_0251560a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

