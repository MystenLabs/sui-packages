module 0xef25d70e99683fcd73cf1707ad0992fa5574e28f0188899e511389eeb6d1b179::fyson {
    struct FYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYSON>(arg0, 6, b"FYSON", b"Fyson Tury", b"Fyson Tury the fallen gipsy king got defeated by Usyk, but still can win in the meme coin world. Lets have some fun guys, join tg, bring the vibes, meme and sticker contests will be going on for rewards! Let's bring the king back to life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_22_01_22_51_3db64e0c51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

