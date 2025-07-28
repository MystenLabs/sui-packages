module 0xb2f0d34da51dc7391178666d61591c09654b46a1d9c1e7519f93bdcfcbac246b::b_ray {
    struct B_RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RAY>(arg0, 9, b"bRAY", b"bToken RAY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

