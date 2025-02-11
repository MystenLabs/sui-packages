module 0xbe4aaaae6ebdabd88579757bc8a5060fe0db4ec52ed05fd646dc74f2cd9baf81::mp {
    struct MP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MP>(arg0, 6, b"MP", b"Millennial Pension  ", b"Millenial Pension Plan is a project for the long haul, this coin will do for crypto what Solana is doing we are just first to the flame. I've been in crypto for a while and my charting is on point. Ill eventually build out the socials. Helping is key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739287429143.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

