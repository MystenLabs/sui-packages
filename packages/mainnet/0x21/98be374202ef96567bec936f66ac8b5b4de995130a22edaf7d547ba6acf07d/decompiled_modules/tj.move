module 0x2198be374202ef96567bec936f66ac8b5b4de995130a22edaf7d547ba6acf07d::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJ>(arg0, 6, b"TJ", b"TOJI", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769656277372.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

