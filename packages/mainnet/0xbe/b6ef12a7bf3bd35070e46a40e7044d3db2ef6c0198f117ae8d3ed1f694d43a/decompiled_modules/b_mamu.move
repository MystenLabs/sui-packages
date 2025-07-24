module 0xbeb6ef12a7bf3bd35070e46a40e7044d3db2ef6c0198f117ae8d3ed1f694d43a::b_mamu {
    struct B_MAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MAMU>(arg0, 9, b"bMAMU", b"bToken MAMU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

