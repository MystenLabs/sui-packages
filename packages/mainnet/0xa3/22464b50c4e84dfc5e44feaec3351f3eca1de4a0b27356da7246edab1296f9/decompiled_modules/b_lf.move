module 0xa322464b50c4e84dfc5e44feaec3351f3eca1de4a0b27356da7246edab1296f9::b_lf {
    struct B_LF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LF>(arg0, 9, b"bLF", b"bToken LF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LF>>(v1);
    }

    // decompiled from Move bytecode v6
}

