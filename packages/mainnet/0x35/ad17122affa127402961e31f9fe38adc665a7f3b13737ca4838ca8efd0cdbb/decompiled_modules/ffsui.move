module 0x35ad17122affa127402961e31f9fe38adc665a7f3b13737ca4838ca8efd0cdbb::ffsui {
    struct FFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFSUI>(arg0, 6, b"FFSUI", b"Flying Fish", x"466c79696e672046697368206973206e6f7720666c79696e67206f76657220616e6420646976696e6720696e746f20746865205375692045636f73797374656d2e2020576520617265206865726520666f726576657220616e6420657665722e20204a6f696e206f75722054656c656772616d21202068747470733a2f2f742e6d652f466c79696e67466973685f5375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flyingfishback_d863091c8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

