module 0x589143206e4fb8086a7cee9aa6c105c9af9cdbd2642e889be2cabe9716d53407::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"COOK on Sui", b"OFFICIAL COOK ON SUI. Just let him $COOK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731527924821.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

