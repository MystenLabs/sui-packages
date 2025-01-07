module 0x3f250f1bab8fb43f298408530a80330e29f5f33673ea9e54635d8a2cf6f882a4::dbl {
    struct DBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBL>(arg0, 6, b"DBL", b"$DeBlobs", b"De $blobs coming on SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955489771.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

