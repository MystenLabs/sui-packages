module 0x3be4f610ec05f30c69c6b2b2818252de8b879701ac61190d2c566f55d68c5209::fbtc {
    struct FBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBTC>(arg0, 6, b"FBTC", b"Fomo bitcoin", b"A new digital currency in a new society Sui Fomo bitcoin New financial freedom, a new world is calling youWe will buy with you in large quantities and sell later  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040048_a0c31dd74e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

