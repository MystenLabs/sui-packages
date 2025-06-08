module 0x33354ee498d62dac72a246e3e11790dc50465df66a4368e49b3ea7666d897b9b::b_code {
    struct B_CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CODE>(arg0, 9, b"bCODE", b"bToken CODE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

