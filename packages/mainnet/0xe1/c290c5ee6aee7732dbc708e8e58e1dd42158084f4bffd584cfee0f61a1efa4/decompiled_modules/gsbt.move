module 0xe1c290c5ee6aee7732dbc708e8e58e1dd42158084f4bffd584cfee0f61a1efa4::gsbt {
    struct GSBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSBT>(arg0, 6, b"GSBT", b"Giga Sui Brett", b"Be Part of the Gigabrett Army! ON SUI CHAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737103443037.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

