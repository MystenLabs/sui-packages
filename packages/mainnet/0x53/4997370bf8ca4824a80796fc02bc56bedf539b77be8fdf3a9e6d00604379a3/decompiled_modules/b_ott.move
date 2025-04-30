module 0x534997370bf8ca4824a80796fc02bc56bedf539b77be8fdf3a9e6d00604379a3::b_ott {
    struct B_OTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OTT>(arg0, 9, b"bOTT", b"bToken OTT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

