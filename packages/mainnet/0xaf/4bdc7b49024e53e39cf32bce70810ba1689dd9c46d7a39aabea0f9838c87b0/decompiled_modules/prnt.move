module 0xaf4bdc7b49024e53e39cf32bce70810ba1689dd9c46d7a39aabea0f9838c87b0::prnt {
    struct PRNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRNT>(arg0, 6, b"PRNT", b"Sui Printer", b"Sui Printer is a meme coin on the Sui blockchain, created to embrace the spirit of cryptocurrencies without pretense. Its sole purpose? To print SUI and generate profit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artbreeder_image_2024_10_14_T14_06_08_043_Z_948fbcef20.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

