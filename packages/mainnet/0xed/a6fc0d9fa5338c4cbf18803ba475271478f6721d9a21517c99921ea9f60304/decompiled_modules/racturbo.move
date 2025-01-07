module 0xeda6fc0d9fa5338c4cbf18803ba475271478f6721d9a21517c99921ea9f60304::racturbo {
    struct RACTURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACTURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACTURBO>(arg0, 6, b"RacTurbo", b"RacTurboSui", b"With my bunny by my side, Rachop and I take the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013044866.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACTURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACTURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

