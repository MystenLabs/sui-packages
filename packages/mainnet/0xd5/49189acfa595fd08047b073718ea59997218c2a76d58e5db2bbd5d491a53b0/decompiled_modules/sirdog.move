module 0xd549189acfa595fd08047b073718ea59997218c2a76d58e5db2bbd5d491a53b0::sirdog {
    struct SIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRDOG>(arg0, 6, b"SIRDOG", b"Sir Dog", x"0a536972646f672069732061206e65772067656e65726174696f6e206d656d65636f696e2074686174206272696e67732074686520737069726974206f6620446f676520746f207468652053756920626c6f636b636861696e20696e20612077617920796f75e280997665206e65766572207365656e206265666f7265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731253485763.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIRDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

