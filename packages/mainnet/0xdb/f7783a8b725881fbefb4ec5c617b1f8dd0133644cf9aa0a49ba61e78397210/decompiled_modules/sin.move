module 0xdbf7783a8b725881fbefb4ec5c617b1f8dd0133644cf9aa0a49ba61e78397210::sin {
    struct SIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIN>(arg0, 6, b"Sin", b"Suiminion", b"Sui minion is meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihyoegvixd6vge36xsqzsghsiuz57xcnobdpmh4duccx3tymazkti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

