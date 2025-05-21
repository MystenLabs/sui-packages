module 0x7e660439a394086e01ed0bdc70c045bb8a8d2fc8bfa3308c54f2095746288c5a::sudoz {
    struct SUDOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOZ>(arg0, 6, b"SUDOZ", b"THESUDOZ", b"Launch token sudoz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicpxpsyopioewcofcpvzxbgtf7qngmt5mfeexvonxhwgbtuj47rui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUDOZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

