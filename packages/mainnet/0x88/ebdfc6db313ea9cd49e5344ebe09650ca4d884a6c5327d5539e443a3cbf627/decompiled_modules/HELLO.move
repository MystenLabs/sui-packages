module 0x88ebdfc6db313ea9cd49e5344ebe09650ca4d884a6c5327d5539e443a3cbf627::HELLO {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HelloCoin", b"HELLO", b"The friendliest meme coin in the crypto universe! Say 'HELLO' to passive income, community vibes, and endless meme potential. No drama, just good vibes and moon missions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/P5rSXUH5Jm4nHllAc8cR8XdIHg5tqWAWo62oErvjOLqkVlRF/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, @0xcefdcee542d102456218259052e8feae0f9a7216378d56e8d5d10cca74d99ffe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

