module 0x234542f9690540b925de1364d0b8c188cfa0b7130506e7a0ff8151341f70582e::aoi {
    struct AOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOI>(arg0, 6, b"AOI", b"SUIAOI AI Agents", b"SUIAOI is not just a simple meme coin, but also a vibrant ecosystem with potential projects. We are developing a series of intelligent bots, capable of creating interesting memes, music, chats and even games based on current trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ch_AE_a_c_A_t_A_n_500_x_360_px_360_x_360_px_2_16dd70a0d4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

