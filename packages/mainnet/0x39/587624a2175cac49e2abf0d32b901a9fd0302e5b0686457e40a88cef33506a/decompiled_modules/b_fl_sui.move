module 0x39587624a2175cac49e2abf0d32b901a9fd0302e5b0686457e40a88cef33506a::b_fl_sui {
    struct B_FL_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FL_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FL_SUI>(arg0, 9, b"bflSUI", b"bToken flSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FL_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FL_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

