module 0xaa2d3f6c236fb611d14cc03d0aae15dbda78920e965b3822851930b8bca151f::b_skn {
    struct B_SKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SKN>(arg0, 9, b"bSKN", b"bToken SKN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

