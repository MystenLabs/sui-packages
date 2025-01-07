module 0x3490c804a0322087795bb6ec7fa6f2bd31e952ed5eeda87c795c266056fc96cd::dgoat {
    struct DGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGOAT>(arg0, 6, b"DGOAT", b"Devil Goat", b"Devil Goat, known as DGOAT, quickly became the top meme on Sui for his chaotic yet hilarious antics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xa5f18ac01063d53ea30fa11f934f72161af823430fdefd90729e50c1ec13da05::dgoat::dgoat.png?size=lg&key=8910f0"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGOAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DGOAT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGOAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

