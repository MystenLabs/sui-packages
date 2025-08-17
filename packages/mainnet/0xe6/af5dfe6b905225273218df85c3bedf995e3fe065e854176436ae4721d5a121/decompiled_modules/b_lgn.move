module 0xe6af5dfe6b905225273218df85c3bedf995e3fe065e854176436ae4721d5a121::b_lgn {
    struct B_LGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LGN>(arg0, 9, b"bLGN", b"bToken LGN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

