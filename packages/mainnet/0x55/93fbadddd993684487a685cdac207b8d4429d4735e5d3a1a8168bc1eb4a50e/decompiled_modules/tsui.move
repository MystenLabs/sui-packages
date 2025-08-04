module 0x5593fbadddd993684487a685cdac207b8d4429d4735e5d3a1a8168bc1eb4a50e::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"TestSUI", b"Testing Creation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadqybgo6c6sazszhueuhrb5edxeglsdjyg4mpr6h4czfj2tass4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

