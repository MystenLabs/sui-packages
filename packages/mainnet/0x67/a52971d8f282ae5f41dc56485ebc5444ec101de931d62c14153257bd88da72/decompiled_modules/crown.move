module 0x67a52971d8f282ae5f41dc56485ebc5444ec101de931d62c14153257bd88da72::crown {
    struct CROWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROWN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CROWN>(arg0, 6, b"CROWN", b"CROWN", b"SuiEmoji Crown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/crown.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROWN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROWN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

