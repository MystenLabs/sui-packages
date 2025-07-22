module 0x8369cdccfef9aaa1ff435830e0449610685f40e2eb15f3b8acde410294933105::downy {
    struct DOWNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWNY>(arg0, 6, b"DOWNY", b"TrenchFi", b"Maybe this is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753198416249.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOWNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

