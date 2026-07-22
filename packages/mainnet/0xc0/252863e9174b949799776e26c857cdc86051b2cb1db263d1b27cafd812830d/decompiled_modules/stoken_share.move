module 0xc0252863e9174b949799776e26c857cdc86051b2cb1db263d1b27cafd812830d::stoken_share {
    struct STOKEN_SHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOKEN_SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOKEN_SHARE>(arg0, 6, b"splyceUSDC", b"Splyce USDC S-Token", b"Tokenized vault share for Splyce USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://splyce.fi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STOKEN_SHARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOKEN_SHARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

