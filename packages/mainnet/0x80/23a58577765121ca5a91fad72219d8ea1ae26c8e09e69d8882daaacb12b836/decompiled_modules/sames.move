module 0x8023a58577765121ca5a91fad72219d8ea1ae26c8e09e69d8882daaacb12b836::sames {
    struct SAMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMES>(arg0, 6, b"SAMES", b"SAME", b"SSS SUIVISION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxnbhmf24mukcva4fbvdh5wz7ptszazjlg2dbqgqtl6q24hl2cz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAMES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

