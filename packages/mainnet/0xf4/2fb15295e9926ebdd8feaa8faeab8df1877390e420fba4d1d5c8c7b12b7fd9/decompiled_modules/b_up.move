module 0xf42fb15295e9926ebdd8feaa8faeab8df1877390e420fba4d1d5c8c7b12b7fd9::b_up {
    struct B_UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UP>(arg0, 9, b"bUP", b"bToken UP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

