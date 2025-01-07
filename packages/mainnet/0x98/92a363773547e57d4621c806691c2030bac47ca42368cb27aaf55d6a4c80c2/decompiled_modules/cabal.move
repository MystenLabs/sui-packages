module 0x9892a363773547e57d4621c806691c2030bac47ca42368cb27aaf55d6a4c80c2::cabal {
    struct CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABAL>(arg0, 6, b"CABAL", b"Cabal", b"Cabal Coins by the same cabal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732670336340.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CABAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

