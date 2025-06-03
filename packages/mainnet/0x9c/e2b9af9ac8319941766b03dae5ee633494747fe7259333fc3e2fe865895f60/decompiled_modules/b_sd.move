module 0x9ce2b9af9ac8319941766b03dae5ee633494747fe7259333fc3e2fe865895f60::b_sd {
    struct B_SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SD>(arg0, 9, b"bSD", b"bToken SD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SD>>(v1);
    }

    // decompiled from Move bytecode v6
}

