module 0x49927fb88ff2a7e293f1bc9a0834581c63d19cecccb8a5abc0a6c4b62c4e1841::b_hawal {
    struct B_HAWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HAWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HAWAL>(arg0, 9, b"bhaWAL", b"bToken haWAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HAWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HAWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

