module 0xcecfe3d472815bb733975595e76da9a70cb6c637bd2f810f2ae5cd7a26efe0e1::b_ffs {
    struct B_FFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FFS>(arg0, 9, b"bFFS", b"bToken FFS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

