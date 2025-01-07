module 0xff7aff2e91d07c2bf0e0641e207f7069cdc9ac4abd043a345ec6e427862bd9b5::dogtrader {
    struct DOGTRADER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTRADER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTRADER>(arg0, 6, b"DOGTRADER", b"A DOGEN TRADER", x"4a7573742061206e6f726d616c20646f672074726164696e6720696e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6091510244736878306_cc1e74e2ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTRADER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTRADER>>(v1);
    }

    // decompiled from Move bytecode v6
}

