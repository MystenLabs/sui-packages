module 0xd2e2176b019f425f543e04a40a3fcf5cbe9c3065b613e764844355cbc5fced8b::xcoin {
    struct XCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCOIN>(arg0, 1, b"XC", b"X-COIN", b"X-COIN is a leading cryptocurrency known for its security and adaptability. Powered by advanced blockchain technology, X-COIN ensures rapid transactions and robust security measures, making it ideal for global use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/favicons/twitter.3.ico")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCOIN>>(v1);
        0x2::coin::mint_and_transfer<XCOIN>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

