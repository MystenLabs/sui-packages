module 0x68e32f4727c90370a88e4d7895393da6b95f8e88eaaa69a6fb9c13bd0e496bca::b_chama {
    struct B_CHAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CHAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CHAMA>(arg0, 9, b"bCHAMA", b"bToken CHAMA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CHAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CHAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

