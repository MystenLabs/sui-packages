module 0x6d0684f3812f36d22ca54db06fe4e92252064835bf90fa121e1e96379e1b2444::lgn {
    struct LGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGN>(arg0, 9, b"LGN", b"Luce green", b"Luce green a good coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5f82ee2d096d7960d4bfcde2920e13dfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

