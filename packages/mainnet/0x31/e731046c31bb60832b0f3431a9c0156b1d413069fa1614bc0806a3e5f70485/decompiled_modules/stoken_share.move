module 0x31e731046c31bb60832b0f3431a9c0156b1d413069fa1614bc0806a3e5f70485::stoken_share {
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

