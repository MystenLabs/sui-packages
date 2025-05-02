module 0x96db91a1d9d3042b677e28d1b29311912448243599925b01cc124d5a8422b7b6::b_smug {
    struct B_SMUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SMUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SMUG>(arg0, 9, b"bSMUG", b"bToken SMUG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SMUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SMUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

