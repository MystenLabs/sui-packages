module 0x25886d2b8141163d7492f568191fd6cd932f17c87aa9db740e87f0e25cd29aa0::b_mon {
    struct B_MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MON>(arg0, 9, b"bMON", b"bToken MON", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MON>>(v1);
    }

    // decompiled from Move bytecode v6
}

