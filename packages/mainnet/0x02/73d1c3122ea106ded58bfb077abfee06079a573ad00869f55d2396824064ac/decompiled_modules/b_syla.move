module 0x273d1c3122ea106ded58bfb077abfee06079a573ad00869f55d2396824064ac::b_syla {
    struct B_SYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SYLA>(arg0, 9, b"bSYLA", b"bToken SYLA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SYLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

