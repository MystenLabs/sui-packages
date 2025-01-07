module 0x3139adf92b7a22ea346faaae90f35e83ba1ec27a8ca30f909ad2a226884afae8::fibl {
    struct FIBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIBL>(arg0, 6, b"FIBL", b"FIBL ON SUI", b"Fibl On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731365097269.6052861")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

