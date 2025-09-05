module 0x31ed5624b1fcf130f6d539ba73d2d9792c62a031d2a052a31fbd169c826d6bdd::tsfiv {
    struct TSFIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSFIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSFIV>(arg0, 9, b"TSFIV", b"TestCoin5", b"This is a test coin. | Website: https://interestlabs.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSFIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSFIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

