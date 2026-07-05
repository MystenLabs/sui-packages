module 0x7973e1e4b82d49feaa25e55ae84d237a4e951abe67cd2be09b67f1b3f526fadc::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYI>(arg0, 6, b"Adeniyi", b"The Bald Bull", b"The Founder of Ocean Blue Bald Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamu7oemgdoz7xb2xceenn5peo7ffsrvnnvum3tfrliyji2drdw3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADENIYI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

