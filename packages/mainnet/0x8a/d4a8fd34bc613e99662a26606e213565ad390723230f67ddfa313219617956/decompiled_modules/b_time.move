module 0x8ad4a8fd34bc613e99662a26606e213565ad390723230f67ddfa313219617956::b_time {
    struct B_TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TIME>(arg0, 9, b"bTIME", b"bToken TIME", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

