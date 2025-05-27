module 0x5d68de79697a391cd4c78f309ec48045443bf24b6a5707d090900ca848fa11f::b_rasine {
    struct B_RASINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RASINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RASINE>(arg0, 9, b"bRASINE", b"bToken RASINE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RASINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RASINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

