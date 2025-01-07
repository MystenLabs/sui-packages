module 0xc5643fd16c65c29446cfd3a97a09f21287d6281cccdc30be369f2adab98a9595::mnk {
    struct MNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNK>(arg0, 6, b"MNK", b"monkey", b"Basket Monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983768893.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

