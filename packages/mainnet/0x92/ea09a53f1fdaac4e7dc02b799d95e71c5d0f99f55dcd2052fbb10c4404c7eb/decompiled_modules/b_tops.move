module 0x92ea09a53f1fdaac4e7dc02b799d95e71c5d0f99f55dcd2052fbb10c4404c7eb::b_tops {
    struct B_TOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TOPS>(arg0, 9, b"bTOPS", b"bToken TOPS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TOPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TOPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

