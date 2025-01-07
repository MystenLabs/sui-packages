module 0xe6e9b8bdec96cb593c44ffdf9e446cc9187ff29db60c2348bd597cd06a21db7::raf {
    struct RAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAF>(arg0, 6, b"RAF", b"RAF the GIRAFFE", x"524146206861732062616c6c7320616e6420612068696768657374206e65636b206f6e206f757220506c616e6574210a436f6d6520616e64204a6f696e20757320746f20746865204d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731945729052.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

