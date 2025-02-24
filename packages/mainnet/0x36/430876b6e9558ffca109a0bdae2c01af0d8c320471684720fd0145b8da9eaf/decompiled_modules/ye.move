module 0x36430876b6e9558ffca109a0bdae2c01af0d8c320471684720fd0145b8da9eaf::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YE>(arg0, 9, b"YE", b"Yeezy", b"frm Ye", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a79c9f4-25dd-4472-911c-47489a7b3368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YE>>(v1);
    }

    // decompiled from Move bytecode v6
}

