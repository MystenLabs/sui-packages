module 0xcaec7ec496ca651a4338a47726d30380281b63baafd671f583d56f4aeca32d58::sukysui {
    struct SUKYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKYSUI>(arg0, 9, b"SUKYSUI", b"SUKYSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761581289/sui_tokens/yoz5wv6vwex5mt17p69q.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUKYSUI>>(0x2::coin::mint<SUKYSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUKYSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUKYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

