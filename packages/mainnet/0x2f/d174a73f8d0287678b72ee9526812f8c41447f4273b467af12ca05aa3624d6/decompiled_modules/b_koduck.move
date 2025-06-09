module 0x2fd174a73f8d0287678b72ee9526812f8c41447f4273b467af12ca05aa3624d6::b_koduck {
    struct B_KODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KODUCK>(arg0, 9, b"bKoduck", b"bToken Koduck", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KODUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

