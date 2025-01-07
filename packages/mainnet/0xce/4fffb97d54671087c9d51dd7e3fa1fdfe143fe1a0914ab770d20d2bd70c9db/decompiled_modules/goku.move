module 0xce4fffb97d54671087c9d51dd7e3fa1fdfe143fe1a0914ab770d20d2bd70c9db::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"SUINGOKU", b"The wait is OVER! Suingoku is here to take the meme coin world by STORM on the powerful Sui Network!  With unstoppable community power and heroic ambition, Suingoku isnt just a meme coin  its a movement! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_14_45_04_26fe94dc0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

