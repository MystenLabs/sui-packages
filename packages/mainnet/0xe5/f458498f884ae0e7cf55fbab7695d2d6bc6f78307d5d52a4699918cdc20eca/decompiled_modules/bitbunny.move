module 0xe5f458498f884ae0e7cf55fbab7695d2d6bc6f78307d5d52a4699918cdc20eca::bitbunny {
    struct BITBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITBUNNY>(arg0, 9, b"BITBUNNY", b"BitBunny meme coin", b"Bitbunny will make memes safe and great again on the Sui network. Join our TG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BITBUNNY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITBUNNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

