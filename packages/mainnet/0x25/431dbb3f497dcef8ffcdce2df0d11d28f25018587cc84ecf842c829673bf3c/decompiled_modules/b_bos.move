module 0x25431dbb3f497dcef8ffcdce2df0d11d28f25018587cc84ecf842c829673bf3c::b_bos {
    struct B_BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BOS>(arg0, 9, b"bBOS", b"bToken BOS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

