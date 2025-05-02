module 0x38cbfa6d91c2508d7e05954c4ec4ee05a3e32d944a134eb6a23b4350964ce23b::b_zup {
    struct B_ZUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZUP>(arg0, 9, b"bZUP", b"bToken ZUP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

