module 0x8d5e01c5a22bd5a79df3cedd921b3216469e7ebedd569e8f906cb6f5985826e::WLRS {
    struct WLRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLRS>(arg0, 6, b"Walrustor", b"WLRS", b"Secure your data with the coolest walrus in town! Walrustor, the stylish teal walrus, protects your files with its expertise in data storage. With its trendy hat, shades, and fresh outfit, this walrus is the epitome of crypto-cool. Invest in WLRS and let Walrustor safeguard your digital treasures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

