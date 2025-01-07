module 0xc71cf65e8117573c578cb448af8b1a1d3fe5c70794741acce7fee6229d078a78::ponk {
    struct PONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONK>(arg0, 6, b"PONK", b"Pochita", b"Pochita is the newest addition to the family of the dog that went viral and became one of the most successful memecoins in crypto to date.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731070655312.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

