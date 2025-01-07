module 0x1e898e93cede78fb17d4dc17970b2057117e29165e10a8a703c56d6fa4528ce9::trempx {
    struct TREMPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMPX>(arg0, 6, b"TrempX", b"TrempX Meme", b"The \"TrempX\" meme is a humorous internet creation that combines elements of President Donald Trump and Elon Musk's social media platform - X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731107997970.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREMPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

