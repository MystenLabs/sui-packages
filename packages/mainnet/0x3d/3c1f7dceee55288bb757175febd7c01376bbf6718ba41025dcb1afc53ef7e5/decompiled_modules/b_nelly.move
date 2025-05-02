module 0x3d3c1f7dceee55288bb757175febd7c01376bbf6718ba41025dcb1afc53ef7e5::b_nelly {
    struct B_NELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NELLY>(arg0, 9, b"bNELLY", b"bToken NELLY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

