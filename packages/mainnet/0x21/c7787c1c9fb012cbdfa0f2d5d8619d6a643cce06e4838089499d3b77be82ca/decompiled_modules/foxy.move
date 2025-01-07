module 0x21c7787c1c9fb012cbdfa0f2d5d8619d6a643cce06e4838089499d3b77be82ca::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 6, b"Foxy", b"Sui Foxy", x"5374617920736d61727420e2809320466f7879206973206865726520746f206c6561642074686520776179f09fa68ae29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960584857.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

