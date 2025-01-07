module 0x4a7fc257f81a302e1694193622ef2221ed0a15d53eae68c627a03fd398b93f2d::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"LEGOARDIO", b"it's LEGOARDIO Hodl Guy on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975692751.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HODL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

