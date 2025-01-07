module 0x4d80578a0970bcd9de7d4bbebfa104021f8ada6f481a507f9fca208b1d83e21f::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"PORING", b"PORING ", b"$PORING - The true meme token on $SUI blockchain with fair distribution on http://turbos.fun platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973547915.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

