module 0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_share {
    struct STOKEN_SHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOKEN_SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOKEN_SHARE>(arg0, 6, b"sUSDC", b"Splyce USDC S-Token", b"Tokenized vault share for Splyce USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://splyce.fi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STOKEN_SHARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOKEN_SHARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

