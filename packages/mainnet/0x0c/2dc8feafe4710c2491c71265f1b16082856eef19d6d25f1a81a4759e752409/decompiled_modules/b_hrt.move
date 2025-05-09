module 0xc2dc8feafe4710c2491c71265f1b16082856eef19d6d25f1a81a4759e752409::b_hrt {
    struct B_HRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HRT>(arg0, 9, b"bHRT", b"bToken HRT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

