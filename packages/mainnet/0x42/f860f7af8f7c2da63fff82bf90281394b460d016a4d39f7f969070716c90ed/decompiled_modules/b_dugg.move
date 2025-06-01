module 0x42f860f7af8f7c2da63fff82bf90281394b460d016a4d39f7f969070716c90ed::b_dugg {
    struct B_DUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DUGG>(arg0, 9, b"bDUGG", b"bToken DUGG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DUGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DUGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

