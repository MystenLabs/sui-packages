module 0x23ed15c8c7a5a60353fdfa6d66bd6b15fbb802c620ad6087abefdd7cb662fdc8::moonberg {
    struct MOONBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBERG>(arg0, 6, b"MOONBERG", b"MOONBERG Togeger", b"Your ticket to the moon!  This meme coin is out of this world, with a community-driven focus and tons of fun. Join the journey and let's blast off together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_3poblk3poblk3pob_d1934ebe24.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

