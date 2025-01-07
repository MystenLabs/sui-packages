module 0xd91e96c27bbf13c96b734807cdba1ba9314e9420691a80a5c0ffe3ec830f9ba2::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 9, b"KOKO", b"KOALA IA", b"Koala generator for ia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FsA54yL49WKs7rWoGv9sUcbSGWCWV756jTD349e6H2yW.png?size=lg&key=80b8bf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOKO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

