module 0x5808058164abd1c4c4f54f08c5ca278e52a4c00b68e6fb2a420ec44f0d78a65::b_mf {
    struct B_MF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MF>(arg0, 9, b"bMF", b"bToken MF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MF>>(v1);
    }

    // decompiled from Move bytecode v6
}

