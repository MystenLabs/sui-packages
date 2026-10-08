module 0x3868e57552b51726a58dbd18aeccc8e96022188e2d6c6da83137dba41839acae::rcat {
    struct RCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RCAT>(arg0, 6, 0x1::string::utf8(b"RCAT"), 0x1::string::utf8(b"SuiRocketCat"), 0x1::string::utf8(b"SuiRocketCat combines internet cat culture with the classic crypto rocket meme. $RCAT is designed as a playful and visually recognizable community token for the Sui ecosystem. The project centers on memes, creat"), 0x1::string::utf8(b"https://popularsui.xyz/media/02854fbae87f7cea3ce5b3fcca9701e4720a731dbad7f78c3e6814819adacb0e.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RCAT>>(0x2::coin_registry::finalize<RCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

