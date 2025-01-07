module 0x9caa6c964b00ef65a6a3f141aaabad51ccba2c1e907a8e70a528ea5842a2368e::gumball {
    struct GUMBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBALL>(arg0, 6, b"GUMBALL", b"GUMBALL SUI", b"Introducing Gumball, the exciting new meme token launching on the Sui Network! Inspired by the playful spirit of gumballs, this token aims to bring fun and creativity to the crypto space. With a focus on community engagement and unique rewards, Gumball is set to create a vibrant ecosystem where laughter and innovation thrive. Join us as we embark on this whimsical journey, celebrating the joy of memes while making our mark in the world of cryptocurrency!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_10_04_09_4a6f2202d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

