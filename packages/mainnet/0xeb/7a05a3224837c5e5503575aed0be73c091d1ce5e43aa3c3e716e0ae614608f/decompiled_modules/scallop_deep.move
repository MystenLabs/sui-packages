module 0xeb7a05a3224837c5e5503575aed0be73c091d1ce5e43aa3c3e716e0ae614608f::scallop_deep {
    struct SCALLOP_DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_DEEP>(arg0, 6, b"sDEEP", b"sDEEP", b"Scallop interest-bearing token for DEEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lkjkjfqta7322ikfbcklyovddpnjqrba3hlhhq4u4ilhcfbbjecq.arweave.net/WpKklhMH960hRQiUvDqjG9qYRCDZ1nPDlOIWcRQhSQU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_DEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_DEEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

