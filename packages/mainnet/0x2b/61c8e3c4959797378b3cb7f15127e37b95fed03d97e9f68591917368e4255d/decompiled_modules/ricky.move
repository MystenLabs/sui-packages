module 0x2b61c8e3c4959797378b3cb7f15127e37b95fed03d97e9f68591917368e4255d::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 6, b"RICKY", b"RICKY on Sui", b"https://app.turbos.finance/fun/#/launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954048545.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

