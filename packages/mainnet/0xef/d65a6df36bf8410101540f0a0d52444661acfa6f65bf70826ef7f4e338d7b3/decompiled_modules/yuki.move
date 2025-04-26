module 0xefd65a6df36bf8410101540f0a0d52444661acfa6f65bf70826ef7f4e338d7b3::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"YUKI", b"YUKI SUI", b"$YUKI is a cute little fluffy furred Yeti and LOFI's son , he's stepping into Water chain as his Dad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcjaidw5dkz2y34ymglrlkvnrmpcjvcai7wljnaypxdrtgjllk6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

