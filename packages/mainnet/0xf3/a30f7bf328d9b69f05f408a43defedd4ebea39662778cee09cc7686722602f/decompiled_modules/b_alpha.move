module 0xf3a30f7bf328d9b69f05f408a43defedd4ebea39662778cee09cc7686722602f::b_alpha {
    struct B_ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ALPHA>(arg0, 9, b"bALPHA", b"bToken ALPHA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

