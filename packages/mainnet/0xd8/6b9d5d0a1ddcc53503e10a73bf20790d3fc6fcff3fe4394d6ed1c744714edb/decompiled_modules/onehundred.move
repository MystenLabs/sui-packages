module 0xd86b9d5d0a1ddcc53503e10a73bf20790d3fc6fcff3fe4394d6ed1c744714edb::onehundred {
    struct ONEHUNDRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEHUNDRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEHUNDRED>(arg0, 6, b"OneHundred", b"100", b"The goal is 100k Mcap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731622572286.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEHUNDRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEHUNDRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

