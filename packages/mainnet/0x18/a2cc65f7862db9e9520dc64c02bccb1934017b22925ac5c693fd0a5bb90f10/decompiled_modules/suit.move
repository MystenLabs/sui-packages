module 0x18a2cc65f7862db9e9520dc64c02bccb1934017b22925ac5c693fd0a5bb90f10::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"Suit", b"CEO of memes", b"Welcome to the wild side of crypto, where the CEO of Memes calls the shots! This is the meme coin for those who like their investments bold, cheeky, and unapologetically fun. If youre ready to laugh your way to the bank and turn those gains into grins, buckle up. Were taking memes, money, and mischief straight to the moon. Lets make some noise and shake up the crypto world! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6885_942cfc8019.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

