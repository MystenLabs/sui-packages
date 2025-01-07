module 0x49f80f443bf14ffb5629ae210d025ca797afa0105797a45d6c210f7ccd8b05ce::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"JEPE", b"JEPE on SUI", b"The most meme able jellyfish on the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955922107.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

