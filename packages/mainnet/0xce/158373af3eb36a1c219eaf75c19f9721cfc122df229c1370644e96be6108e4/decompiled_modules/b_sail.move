module 0xce158373af3eb36a1c219eaf75c19f9721cfc122df229c1370644e96be6108e4::b_sail {
    struct B_SAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SAIL>(arg0, 9, b"bSAIL", b"bToken SAIL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

