module 0x985b3321617abbbdb87240e8972f9c98ddeb29bd7c2b269f212a8038f470e5cb::b_ausd {
    struct B_AUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_AUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_AUSD>(arg0, 9, b"bAUSD", b"bToken AUSD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_AUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_AUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

