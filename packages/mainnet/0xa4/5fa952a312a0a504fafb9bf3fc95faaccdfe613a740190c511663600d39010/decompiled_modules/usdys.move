module 0xa45fa952a312a0a504fafb9bf3fc95faaccdfe613a740190c511663600d39010::usdys {
    struct USDYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<USDYS>(arg0, 6, b"USDYs", b"Staging Ondo US Dollar Yield", b"Staging Ondo US Dollar Yield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ondo.finance/images/tokens/usdy.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDYS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<USDYS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

