module 0xb28ce3c4f42ef9a9350e1730abb785faf6b91fb43725bb8d2fe6b1f920855f3c::b_lgt {
    struct B_LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LGT>(arg0, 9, b"bLGT", b"bToken LGT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

