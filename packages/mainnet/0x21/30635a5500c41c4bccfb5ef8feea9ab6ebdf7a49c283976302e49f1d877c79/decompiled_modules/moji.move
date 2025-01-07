module 0x2130635a5500c41c4bccfb5ef8feea9ab6ebdf7a49c283976302e49f1d877c79::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"Moji Agent", x"f09fa4962054686520666972737420656d6f6a69206167656e7420f09fa496", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735832009398.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

