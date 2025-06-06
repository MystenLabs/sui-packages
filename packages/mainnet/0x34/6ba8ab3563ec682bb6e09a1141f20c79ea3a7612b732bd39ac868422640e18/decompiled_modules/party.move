module 0x346ba8ab3563ec682bb6e09a1141f20c79ea3a7612b732bd39ac868422640e18::party {
    struct PARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTY>(arg0, 6, b"Party", b"Xparty", b"Xparty for the people by the people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749169510165.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

