module 0xeaf362e30c298e4770127ba8e63a7c8b4d1597146022992a415ca74e7915ea37::pophop {
    struct POPHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPHOP>(arg0, 6, b"Pophop", b"PopHop", b"WE ARE POPHOPPP!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967082752.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

