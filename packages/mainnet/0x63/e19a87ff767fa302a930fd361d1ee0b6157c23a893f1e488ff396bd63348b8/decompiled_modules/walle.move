module 0x63e19a87ff767fa302a930fd361d1ee0b6157c23a893f1e488ff396bd63348b8::walle {
    struct WALLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLE>(arg0, 6, b"Walle", b"Walle On Sui", b"Be a Walle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiclgvrv3xbcf3mbqmvn3yyfbracnbneixvcw6tpuzeflmxdglhy5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

