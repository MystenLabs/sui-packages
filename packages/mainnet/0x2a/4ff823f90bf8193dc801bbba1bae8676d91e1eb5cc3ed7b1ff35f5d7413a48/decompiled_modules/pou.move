module 0x2a4ff823f90bf8193dc801bbba1bae8676d91e1eb5cc3ed7b1ff35f5d7413a48::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"POU", b"Pou On Sui", b"Pou has arrived on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739041897098.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

