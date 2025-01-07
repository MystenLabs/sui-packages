module 0x1323c28ef9b34e955a7e39cecee025999469cf989d39b5934fbfbc8794c4d9ca::cabal {
    struct CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABAL>(arg0, 6, b"CABAL", b"Call A Banger And Leave", b"One call is all it takes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_164856_195_4601a4e33d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

