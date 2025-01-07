module 0x1037fb00189a519b6ef8ce3378e3b0911160faf03a1d0c5ab2ad70ed59a92a1::resist {
    struct RESIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESIST>(arg0, 6, b"RESIST", b"Resist AI", b"$RESIST symbolizes the refusal to surrender our uniqueness to the tidal wave of AI technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735027018033.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESIST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESIST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

