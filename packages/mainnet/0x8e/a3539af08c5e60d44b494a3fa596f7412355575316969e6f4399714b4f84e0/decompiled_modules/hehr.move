module 0x8ea3539af08c5e60d44b494a3fa596f7412355575316969e6f4399714b4f84e0::hehr {
    struct HEHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHR>(arg0, 6, b"Hehr", b"Gshd", b"Jehd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989519482.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

