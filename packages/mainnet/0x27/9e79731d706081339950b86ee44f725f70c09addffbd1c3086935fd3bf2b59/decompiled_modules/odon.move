module 0x279e79731d706081339950b86ee44f725f70c09addffbd1c3086935fd3bf2b59::odon {
    struct ODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODON>(arg0, 6, b"ODON", b"Sui ODON", b"ODON is the wealth protector on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964469380.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

