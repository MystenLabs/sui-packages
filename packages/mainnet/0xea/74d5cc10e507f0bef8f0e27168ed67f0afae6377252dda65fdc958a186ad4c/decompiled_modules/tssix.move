module 0xea74d5cc10e507f0bef8f0e27168ed67f0afae6377252dda65fdc958a186ad4c::tssix {
    struct TSSIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSSIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSSIX>(arg0, 9, b"TSSIX", b"TestCoin6", b"This is a test coin. | Website: https://interestlabs.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSSIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSSIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

