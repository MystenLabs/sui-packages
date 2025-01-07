module 0xac0513968644e39c7bc6bc9192126b07d0be5f548dd03d5f3f44a2c03d0184c0::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 9, b"NEPTUNE", b"Sea's God", x"4e657074756e6520697320476f64206f662053656120696e20526f6d616e204d7974686f6c6f67792e2048697320706f77657220697320676f7665726e616e63652065766572797468696e6720746861742062656c6f6e6720746f207761746572776f726c64206576656e207761766520f09f8c8a2048697320706f77657266756c2073796d626f6c2069732054726964656e7420f09f94b1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dde749e7-0010-40ae-8499-aca90914fce2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEPTUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

