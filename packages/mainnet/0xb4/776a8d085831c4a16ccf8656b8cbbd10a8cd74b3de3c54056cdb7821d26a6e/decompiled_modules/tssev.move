module 0xb4776a8d085831c4a16ccf8656b8cbbd10a8cd74b3de3c54056cdb7821d26a6e::tssev {
    struct TSSEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSSEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSSEV>(arg0, 9, b"TSSEV", b"TestCoin7", b"This is a test coin. | Website: https://interestlabs.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSSEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSSEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

