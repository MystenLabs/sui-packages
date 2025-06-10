module 0x846cb796587fe837c158084c22581f874b0c3ee0f2aea1bf2a4f84c894e20793::b_root {
    struct B_ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ROOT>(arg0, 9, b"bROOT", b"bToken ROOT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

