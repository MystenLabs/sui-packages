module 0x47129076404f5ddd4b8eb297c5fb5fdce22733bce464d0f6cfea6b8ef94a3dd5::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"Poke", b"Pokemon", b"Poke the pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBVAXGJ5QWZFF04ERMBMSZEF/01JCBB83NWHR1W3HZTGKRCS1WN")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

