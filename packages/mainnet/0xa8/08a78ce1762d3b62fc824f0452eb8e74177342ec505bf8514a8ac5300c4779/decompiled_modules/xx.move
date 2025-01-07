module 0xa808a78ce1762d3b62fc824f0452eb8e74177342ec505bf8514a8ac5300c4779::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 6, b"XX", b"Chromosome", x"46726f6d20646f75626c652068656c697820746f20646f75626c65206761696e732e204a6f696e2074686520245858207265766f6c7574696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735945862078.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

