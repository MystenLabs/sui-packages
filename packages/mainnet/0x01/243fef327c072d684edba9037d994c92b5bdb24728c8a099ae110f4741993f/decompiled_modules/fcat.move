module 0x1243fef327c072d684edba9037d994c92b5bdb24728c8a099ae110f4741993f::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"Fcat", b"FlyCat", b"A cat flies towards you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999816633.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

