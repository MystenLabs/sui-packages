module 0xe3cb568170ad7833b917af7cebf8ac6282061d5f467adbb1f5791632dab96544::b_law {
    struct B_LAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LAW>(arg0, 9, b"bLAW", b"bToken LAW", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

