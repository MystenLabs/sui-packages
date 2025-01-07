module 0x9c83ee51f530bb9895038798129d457ca29c2a810d30995dc0bb336fc526aa3e::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"YAWN ON SUI", b"Meet Yawn, the sleepiest member of the group. He was so deep in slumber that he missed the invitation to join the Boys' Club, a regret he's carried ever since. Determined to rise above, Yawn is now launching his own venture with $YAWN, the world's first meme token that enables holders to earn profits from businesses and services developed under the Yawn brand. Our mission is to make Yawn a household name, fostering a community that amplifies our brand's influence. It's Yawn's world; you're just living in it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_yawn_df6e6c62e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

