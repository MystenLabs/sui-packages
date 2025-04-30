module 0xbf374442e985ddc8eced438c6d99c0240a8a6fd9364dd9de72a670a416c525bc::b_gmb {
    struct B_GMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GMB>(arg0, 9, b"bGMB", b"bToken GMB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

