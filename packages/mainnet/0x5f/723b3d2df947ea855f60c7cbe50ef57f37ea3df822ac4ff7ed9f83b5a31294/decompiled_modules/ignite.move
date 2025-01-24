module 0x5f723b3d2df947ea855f60c7cbe50ef57f37ea3df822ac4ff7ed9f83b5a31294::ignite {
    struct IGNITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGNITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGNITE>(arg0, 6, b"IGNITE", b"Dan Bilzerian", b" $IGNITE is Dan Bilzerian's official meme coin, bringing the billionaire's irreverent and bold energy to the world of cryptocurrencies. With a community of loyal fans and a unique vibe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250125_040626_379_7106e0ebe5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGNITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGNITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

