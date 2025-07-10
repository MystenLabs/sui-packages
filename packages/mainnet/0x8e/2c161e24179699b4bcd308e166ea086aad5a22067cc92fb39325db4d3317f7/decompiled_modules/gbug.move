module 0x8e2c161e24179699b4bcd308e166ea086aad5a22067cc92fb39325db4d3317f7::gbug {
    struct GBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBUG>(arg0, 6, b"Gbug", b"gold bug", b"a gold bug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievcgo7cl763mucxsxk6ajvafmunyckpflfs4ndvyei3ixfmccddi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GBUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

