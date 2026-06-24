module 0x3e1e27395675941fd8584ca883c27ae2bebcfab2f2d68a5a626503fc6ee09da9::b_code {
    struct B_CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CODE>(arg0, 9, b"bCODE", b"bToken CODE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

