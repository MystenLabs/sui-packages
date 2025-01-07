module 0x4cb81643a561d165148d7e3833b544171b22eea758c1b71503ec147e55e3e7df::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"BLACK SUI ", x"24424c41434b20535549206974732061206e6577206d65746120646f67206f6e2053554920636861696e20646f6ee280997420666164652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731200431799.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

