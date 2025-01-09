module 0x91da223846bd15dfe60c5ac4e1ae3c7a4f7e174df9a7e728a636e4bbbb331518::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 6, b"Sushi", b"Sushi_on_sui", b"Sushi on the Sui blockchain hold for rolls ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736455825690.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

