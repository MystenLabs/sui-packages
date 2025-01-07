module 0x68d4ed20ff175a1583e18b2dfa096b3a2894618058422d1537cfe2f2300f5661::dbl {
    struct DBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBL>(arg0, 6, b"DBL", b"Ded Before Launch", b"This is DBL. Our success depends on you. If you don't believe in us, we are ded before launch. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959464815.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

