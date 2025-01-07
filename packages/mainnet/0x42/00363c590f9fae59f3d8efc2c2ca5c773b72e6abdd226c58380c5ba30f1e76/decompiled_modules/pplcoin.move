module 0x4200363c590f9fae59f3d8efc2c2ca5c773b72e6abdd226c58380c5ba30f1e76::pplcoin {
    struct PPLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPLCOIN>(arg0, 6, b"PPLcoin", b"PPL coin", b"A coin by the PPL For The PPL ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736111265919.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPLCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPLCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

