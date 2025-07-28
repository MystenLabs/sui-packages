module 0x1c9075382f2ccadf1d1cca3f0d54b5dc8ff95998547c839446b505af2d50ea1c::b_cguy {
    struct B_CGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CGUY>(arg0, 9, b"bCGUY", b"bToken CGUY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

