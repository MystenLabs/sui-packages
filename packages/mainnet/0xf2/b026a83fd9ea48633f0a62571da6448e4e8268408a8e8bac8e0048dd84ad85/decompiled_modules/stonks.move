module 0xf2b026a83fd9ea48633f0a62571da6448e4e8268408a8e8bac8e0048dd84ad85::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 9, b"STONKS", b"Sui Stonks", b"Sui Stonks is a meme token that plays on the famous \"stonks\" meme, symbolizing rising profits and financial gains. It brings a fun, humorous spin to the Sui ecosystem, perfect for those who love lighthearted investments while aiming to ride the next big upward trend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823116061832572928/Jk_JNcwC.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONKS>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

