module 0x431dc9b93cd6aba00b7766f7d5b9588d851b49005bbf9ad9337a7a56ce7c9910::tsnail {
    struct TSNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSNAIL>(arg0, 6, b"TSNAIL", b"turbosnail", b"TURBO SNAILLL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949896000.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSNAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSNAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

