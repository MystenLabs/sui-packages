module 0xc5741655886c495d7d101e40a95c8d5ffe980c0e6075c9228d603ff19cdc1183::babypengu {
    struct BABYPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPENGU>(arg0, 6, b"BabyPengu", b"Baby Pengu", b"Just a baby pengu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibydotkfpvdg6kj6ylu76oppbyc5twfszqbqaxdulr2h3zqkxvhwm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYPENGU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

