module 0x36dd4483d693fb708509958b2f7190c39d38a661f93d3239d4a7bdd276d5698b::b_pking {
    struct B_PKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PKING>(arg0, 9, b"bPKING", b"bToken PKING", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

