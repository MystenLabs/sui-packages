module 0x8b4e276c7377ab6b26fc28eadf55337a3e8c272d89c394b8440ba86a1999df1d::spsui {
    struct SPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPSUI>(arg0, 6, b"SPSUI", b"SpiderSUI", b"This is a token RELAUNCH - we are moving from MOVEPUMP to MOONBAGS. We have our own Buy Bot, Trending System and upcoming earning modules.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie7fpuflg5un2bs3swistbnorrbefirfnmofvhok64jbc3p5w22uu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

