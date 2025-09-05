module 0xe0297a49a45b21cb14f5ad702c781bfc8f4ca61289f2e3228ebf00309d46b032::tstre {
    struct TSTRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTRE>(arg0, 9, b"TSTRE", b"TestCoin3", b"This is a test coin. | Website: https://interestlabs.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSTRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

