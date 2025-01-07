module 0x443fb7fdfed8bf25a44d204ad9426b3c5c2c04e9c965435f956524b276497eb8::robo {
    struct ROBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBO>(arg0, 6, b"ROBO", b"ROBOT ON SUI", b"Each $ROBO is unique and represents a variety of meme themes, ranging from famous internet moments and viral trends to exclusively designed memes. #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ROBOT_3e9312c12e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

