module 0xef6e35da07eb4cdfffcff7ed706e7070924a8be5f595a8829947268a6cd1e437::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"DARK MAGA ASSEMBLY", b"PURE CELEBATORY MEME, ALL FUN, NO PROMISES BUT I WILL PUSH THIS WITH MY PERSONAL TWITTER ACCOUNT AND SOME MARKETING FOLLOWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_ecf3cee2_09f0_4385_a385_1c520349a43a_447ee25e59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

