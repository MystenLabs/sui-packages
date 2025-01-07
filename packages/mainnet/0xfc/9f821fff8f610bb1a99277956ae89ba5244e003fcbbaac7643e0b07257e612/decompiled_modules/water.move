module 0xfc9f821fff8f610bb1a99277956ae89ba5244e003fcbbaac7643e0b07257e612::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Squirtle", x"5371756972746c65203a205468652077617465722d6c6f76696e672c20686172642d7368656c6c6564206865726f2120466173742c206669657263652c20616e6420616c7761797320726561647920746f2070726f746563742069747320667269656e64732077697468206120626c617374206f662077617465722066726f6d2069747320747275737479207461696c2e204361746368206d6520696620796f752063616e21200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_a0598ea189.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

