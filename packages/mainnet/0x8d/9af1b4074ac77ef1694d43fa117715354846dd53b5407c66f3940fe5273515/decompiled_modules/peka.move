module 0x8d9af1b4074ac77ef1694d43fa117715354846dd53b5407c66f3940fe5273515::peka {
    struct PEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEKA>(arg0, 6, b"PEKA", b"PEKA SUI", b"$PEKA The Bad Girl!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plague_93200a1d78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

