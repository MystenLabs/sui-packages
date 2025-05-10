module 0x24e109918d1c8eb38af69e593363fe47ecfc70b64561de9f28c173b73e40bff8::pezilla {
    struct PEZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEZILLA>(arg0, 6, b"PEZILLA", b"Pezilla Token", b"Introducing Pezilla, the ultimate memecoin on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifx43237a6lhlqynilxdxtkupg2wgmxfkjxh6gfzsia6xovai2yo4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEZILLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

