module 0x960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy {
    struct USDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<USDY>(arg0, 6, b"USDY", b"Ondo US Dollar Yield", b"Ondo US Dollar Yield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ondo.finance/images/tokens/usdy.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<USDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

