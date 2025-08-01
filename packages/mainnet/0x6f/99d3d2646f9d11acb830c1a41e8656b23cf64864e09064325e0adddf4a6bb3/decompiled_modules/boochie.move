module 0x6f99d3d2646f9d11acb830c1a41e8656b23cf64864e09064325e0adddf4a6bb3::boochie {
    struct BOOCHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOCHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOCHIE>(arg0, 6, b"BOOCHIE", b"Boochie By MF", b"Matt Furie's new art book, \"Cortex Vortex,\" features Boochie as one of its characters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3a7rk37ihqmlx5strz3qjbejxeloekkghjxiqtfourqxjlrixtq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOCHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOCHIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

