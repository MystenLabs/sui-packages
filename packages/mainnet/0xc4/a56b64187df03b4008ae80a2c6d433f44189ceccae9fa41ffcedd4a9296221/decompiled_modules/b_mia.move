module 0xc4a56b64187df03b4008ae80a2c6d433f44189ceccae9fa41ffcedd4a9296221::b_mia {
    struct B_MIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MIA>(arg0, 9, b"bMIA", b"bToken MIA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

