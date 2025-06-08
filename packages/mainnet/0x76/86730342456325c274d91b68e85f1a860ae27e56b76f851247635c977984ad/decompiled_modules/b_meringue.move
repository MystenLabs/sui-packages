module 0x7686730342456325c274d91b68e85f1a860ae27e56b76f851247635c977984ad::b_meringue {
    struct B_MERINGUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MERINGUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MERINGUE>(arg0, 9, b"bMERINGUE", b"bToken MERINGUE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MERINGUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MERINGUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

