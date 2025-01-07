module 0x2b78d4bc9a3bf272173d5f61786504f713bff5a0ea5a40acfaec914e564db2f::bbg {
    struct BBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBG>(arg0, 6, b"BBG", b"ByeByeGary", b"\"ByeByeGary ($BBG) is a meme coin on the Sui network, created to say goodbye to overregulation! Let's celebrate crypto freedom with memes and fun.  #ByeByeGary\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_humorous_and_realistic_meme_style_image_represen_1_1e2d17b4b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

