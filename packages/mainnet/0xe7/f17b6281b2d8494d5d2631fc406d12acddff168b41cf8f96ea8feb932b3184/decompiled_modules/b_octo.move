module 0xe7f17b6281b2d8494d5d2631fc406d12acddff168b41cf8f96ea8feb932b3184::b_octo {
    struct B_OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OCTO>(arg0, 9, b"bOCTO", b"bToken OCTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

