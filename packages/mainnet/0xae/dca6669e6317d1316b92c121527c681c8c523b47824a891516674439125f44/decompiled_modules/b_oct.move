module 0xaedca6669e6317d1316b92c121527c681c8c523b47824a891516674439125f44::b_oct {
    struct B_OCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OCT>(arg0, 9, b"bOCT", b"bToken OCT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

