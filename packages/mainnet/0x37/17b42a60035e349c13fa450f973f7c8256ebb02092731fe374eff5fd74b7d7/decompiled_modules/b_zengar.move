module 0x3717b42a60035e349c13fa450f973f7c8256ebb02092731fe374eff5fd74b7d7::b_zengar {
    struct B_ZENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZENGAR>(arg0, 9, b"bZENGAR", b"bToken ZENGAR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

