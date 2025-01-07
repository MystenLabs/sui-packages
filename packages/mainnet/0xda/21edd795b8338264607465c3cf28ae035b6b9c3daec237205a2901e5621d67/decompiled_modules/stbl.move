module 0xda21edd795b8338264607465c3cf28ae035b6b9c3daec237205a2901e5621d67::stbl {
    struct STBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STBL>(arg0, 6, b"STBL", b"SUItable", x"e280986c656176696e6720535549206f6e20746865207461626c65e28099", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731041158621.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

