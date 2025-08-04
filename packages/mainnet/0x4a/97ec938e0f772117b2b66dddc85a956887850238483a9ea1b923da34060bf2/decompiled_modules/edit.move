module 0x4a97ec938e0f772117b2b66dddc85a956887850238483a9ea1b923da34060bf2::edit {
    struct EDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EDIT>(arg0, 6, b"EDIT", b"Edit", b"Edit meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Untitled_c607766f24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EDIT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDIT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

