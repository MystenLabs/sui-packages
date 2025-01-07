module 0x606f78a97bddebc5abe5f20d484a729af2fa1bc5fb434687e495790b6ad50a11::gumball {
    struct GUMBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBALL>(arg0, 6, b"GUMBALL", b"Gumball", b"The exciting new meme token launching on the Sui Network! Inspired by the playful spirit of gumballs, this token aims to bring fun and creativity to the crypto space. With a focus on community engagement and unique rewards, Gumball is set to create a vibrant ecosystem where laughter and innovation thrive. Join us as we embark on this whimsical journey, celebrating the joy of memes while making our mark in the world of cryptocurrency!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_640a451651.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

