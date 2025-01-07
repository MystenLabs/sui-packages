module 0x3a7efdb28a7449b6d62f52382bdce491c85080a322894c9cd20a892c0b26b36c::snooai {
    struct SNOOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOAI>(arg0, 6, b"SNOOAI", b"Snoo AI ", x"596f75e280997665207365656e2068696d2061726f756e64206275742068657265e2809973206d6f726521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736018051341.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOOAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

