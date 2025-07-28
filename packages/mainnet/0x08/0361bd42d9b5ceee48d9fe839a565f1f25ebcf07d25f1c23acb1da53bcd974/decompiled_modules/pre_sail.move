module 0x80361bd42d9b5ceee48d9fe839a565f1f25ebcf07d25f1c23acb1da53bcd974::pre_sail {
    struct PRE_SAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRE_SAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRE_SAIL>(arg0, 6, b"preSAIL", b"preSAIL", b"Full Sail Governance Token Preview", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.fullsail.finance/static_files/sail_test_coin.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRE_SAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRE_SAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

