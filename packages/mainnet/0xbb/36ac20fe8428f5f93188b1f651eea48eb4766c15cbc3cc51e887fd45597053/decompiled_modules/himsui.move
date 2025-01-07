module 0xbb36ac20fe8428f5f93188b1f651eea48eb4766c15cbc3cc51e887fd45597053::himsui {
    struct HIMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIMSUI>(arg0, 6, b"HIMSUI", b"HIM", b"The last President's son", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000007452_ded65018c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIMSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIMSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

