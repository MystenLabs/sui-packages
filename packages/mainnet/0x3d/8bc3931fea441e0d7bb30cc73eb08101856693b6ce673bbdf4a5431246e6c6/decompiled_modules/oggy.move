module 0x3d8bc3931fea441e0d7bb30cc73eb08101856693b6ce673bbdf4a5431246e6c6::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 6, b"OGGY", b"Oggy Inu", b"OGGYINU - newest and most exciting memecoin! With a community-driven approach and a burning passion for memes, they believe Oggy Inu is the next big thing in the meme market. Join on this journey to revolutionize the world of memecoins and let's go to the moon together! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Mc392d3_400x400_7c5cc8fede.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

