module 0xcfc8e5ca06feecbe493f93f21419aa4bcf152a5596765762508d919096975217::b_am {
    struct B_AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_AM>(arg0, 9, b"bAM", b"bToken AM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_AM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

