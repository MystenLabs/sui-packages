module 0x83847bcb5d4b2a59f82a5c4165919c88cb5a0c1636910ff68411d3c31a75538::b_isui {
    struct B_ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ISUI>(arg0, 9, b"biSUI", b"bToken iSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

