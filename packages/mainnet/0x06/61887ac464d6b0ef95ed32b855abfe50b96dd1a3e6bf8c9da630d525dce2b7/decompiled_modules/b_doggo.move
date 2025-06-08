module 0x661887ac464d6b0ef95ed32b855abfe50b96dd1a3e6bf8c9da630d525dce2b7::b_doggo {
    struct B_DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DOGGO>(arg0, 9, b"bDOGGO", b"bToken DOGGO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

