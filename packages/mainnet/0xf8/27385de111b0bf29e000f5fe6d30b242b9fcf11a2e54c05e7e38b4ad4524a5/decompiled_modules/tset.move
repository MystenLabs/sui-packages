module 0xf827385de111b0bf29e000f5fe6d30b242b9fcf11a2e54c05e7e38b4ad4524a5::tset {
    struct TSET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSET>(arg0, 9, b"TSET", b"Coin Test", b"This is a test coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TSET>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSET>>(v1);
    }

    // decompiled from Move bytecode v6
}

