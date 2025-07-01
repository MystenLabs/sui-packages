module 0x480da386d8805329f8c3a9027b69474ee0dc96af33c446089a3514b58a62288c::b_bbn {
    struct B_BBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BBN>(arg0, 9, b"bBBN", b"bToken BBN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

