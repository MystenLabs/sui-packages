module 0x512b19ba7b62d339fd419336d78f3dbaa289283f8f9eeb4e1cdbd818ae721477::svidia {
    struct SVIDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVIDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVIDIA>(arg0, 9, b"SVIDIA", b"SuVidia", b"Newest, hottest meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1748035354475823105/VkENH0r4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SVIDIA>(&mut v2, 220000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVIDIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVIDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

