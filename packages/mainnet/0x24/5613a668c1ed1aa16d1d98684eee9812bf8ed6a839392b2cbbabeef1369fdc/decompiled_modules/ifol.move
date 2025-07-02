module 0x245613a668c1ed1aa16d1d98684eee9812bf8ed6a839392b2cbbabeef1369fdc::ifol {
    struct IFOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFOL>(arg0, 9, b"IFOL", b"ifol", b"lofi backwards. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/04f1fff1-7f67-4863-9822-c3b9dd6a150a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

