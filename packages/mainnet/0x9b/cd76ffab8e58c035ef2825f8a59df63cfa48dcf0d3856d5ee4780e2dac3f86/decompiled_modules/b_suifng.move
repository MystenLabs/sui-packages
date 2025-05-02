module 0x9bcd76ffab8e58c035ef2825f8a59df63cfa48dcf0d3856d5ee4780e2dac3f86::b_suifng {
    struct B_SUIFNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUIFNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUIFNG>(arg0, 9, b"bSUIFNG", b"bToken SUIFNG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUIFNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUIFNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

