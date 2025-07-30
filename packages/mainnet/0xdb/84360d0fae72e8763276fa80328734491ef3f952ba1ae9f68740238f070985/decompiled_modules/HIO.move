module 0xdb84360d0fae72e8763276fa80328734491ef3f952ba1ae9f68740238f070985::HIO {
    struct HIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIO>(arg0, 6, b"Hole In One", b"HIO", b"A meme coin celebrating the rarest and most exhilarating feat in golf! Perfect for crypto degens and golf enthusiasts alike. Every HIO holder gets a chance to win real golf gear and exclusive NFTs. Drive your portfolio to the green with HIO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/fuMbTsoALaVGJqIKyESz6TtWIehjwRBtCNeAHhqejuqSzevoC/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIO>>(v0, @0xcefdcee542d102456218259052e8feae0f9a7216378d56e8d5d10cca74d99ffe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

