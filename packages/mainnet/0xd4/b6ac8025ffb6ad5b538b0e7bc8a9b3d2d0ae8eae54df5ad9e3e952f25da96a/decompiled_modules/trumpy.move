module 0xd4b6ac8025ffb6ad5b538b0e7bc8a9b3d2d0ae8eae54df5ad9e3e952f25da96a::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"TRUMPY", b"Trump Party", b"Celebrate Trump's 47th win at Sui Beach! Join the epic party with $TRUMPY and be part of history on the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logooo_e955ef80c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

