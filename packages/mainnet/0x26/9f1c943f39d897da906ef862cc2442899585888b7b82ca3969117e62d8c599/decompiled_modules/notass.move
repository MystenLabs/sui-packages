module 0x269f1c943f39d897da906ef862cc2442899585888b7b82ca3969117e62d8c599::notass {
    struct NOTASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTASS>(arg0, 6, b"NOTASS", b"NOTASSCOIN", b"NOT ASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750293129574.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

