module 0xcede935ad5f38d2d39803399735ce63bc15ebe208dc0c4d9c0bab4b554d3a3a0::b_suiagent {
    struct B_SUIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUIAGENT>(arg0, 9, b"bSUIAGENT", b"bToken SUIAGENT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUIAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUIAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

