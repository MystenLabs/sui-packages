module 0x56dfdc1a799bd352acad9617a4aaa9529392f785bb4b83cfa7e07dcfc1ec9d8d::b_suie {
    struct B_SUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUIE>(arg0, 9, b"bSUIE", b"bToken SUIE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

