module 0x976b4237920e32ba1117afce20b2299db96cb9c3dab41d58831ca9fb86e09836::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBO>(arg0, 6, b"SUIBO", b"Suibo on sui", b"SUIBO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3e4wory44wkw6jgh6k6hdxt2mchfdewdhk4eifmdwe5kyvolzpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

