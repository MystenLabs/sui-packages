module 0xfae8dc6bf7b9d8713f31fcf723f57c251c42c067e7e5c4ef68c1de09652db3cf::SAIL {
    struct SAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIL>(arg0, 6, b"SAIL", b"SAIL", b"Full Sail Governance Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.fullsail.finance/static_files/sail_coin.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

