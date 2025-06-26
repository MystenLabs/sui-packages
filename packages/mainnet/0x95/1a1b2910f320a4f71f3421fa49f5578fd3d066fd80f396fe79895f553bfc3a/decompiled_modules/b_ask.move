module 0x951a1b2910f320a4f71f3421fa49f5578fd3d066fd80f396fe79895f553bfc3a::b_ask {
    struct B_ASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ASK>(arg0, 9, b"bASK", b"bToken ASK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

