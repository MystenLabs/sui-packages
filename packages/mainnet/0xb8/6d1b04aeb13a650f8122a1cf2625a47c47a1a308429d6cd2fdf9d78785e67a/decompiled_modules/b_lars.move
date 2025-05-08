module 0xb86d1b04aeb13a650f8122a1cf2625a47c47a1a308429d6cd2fdf9d78785e67a::b_lars {
    struct B_LARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LARS>(arg0, 9, b"bLARS", b"bToken LARS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

