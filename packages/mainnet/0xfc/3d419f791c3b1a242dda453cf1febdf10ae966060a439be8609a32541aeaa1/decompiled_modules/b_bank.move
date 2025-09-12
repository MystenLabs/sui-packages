module 0xfc3d419f791c3b1a242dda453cf1febdf10ae966060a439be8609a32541aeaa1::b_bank {
    struct B_BANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BANK>(arg0, 9, b"bBANK", b"bToken BANK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

