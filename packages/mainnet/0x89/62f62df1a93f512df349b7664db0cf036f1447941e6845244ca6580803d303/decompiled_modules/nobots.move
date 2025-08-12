module 0x8962f62df1a93f512df349b7664db0cf036f1447941e6845244ca6580803d303::nobots {
    struct NOBOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBOTS>(arg0, 6, b"NOBOTS", b"NOBOTSINBOSS", b"No bots pls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigvttna5dgb3gtbhb5rhaiyauuujhu7l7oe4qsblddbz4vbf5iy7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOBOTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

