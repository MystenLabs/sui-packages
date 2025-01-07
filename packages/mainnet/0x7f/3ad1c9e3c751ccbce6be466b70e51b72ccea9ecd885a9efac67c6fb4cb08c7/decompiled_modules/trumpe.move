module 0x7f3ad1c9e3c751ccbce6be466b70e51b72ccea9ecd885a9efac67c6fb4cb08c7::trumpe {
    struct TRUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPE>(arg0, 6, b"TRUMPE", b"$TRUMPE", x"245452554d504520697320726561647920746f20636f6e7175657220746865204d41545249580a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999652975.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

