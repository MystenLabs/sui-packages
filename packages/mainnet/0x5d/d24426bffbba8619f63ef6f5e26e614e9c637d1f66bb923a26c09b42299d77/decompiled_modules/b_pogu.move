module 0x5dd24426bffbba8619f63ef6f5e26e614e9c637d1f66bb923a26c09b42299d77::b_pogu {
    struct B_POGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POGU>(arg0, 9, b"bPOGU", b"bToken POGU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

