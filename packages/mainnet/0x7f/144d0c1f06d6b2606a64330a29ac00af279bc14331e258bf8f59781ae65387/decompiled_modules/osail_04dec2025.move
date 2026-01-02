module 0x7f144d0c1f06d6b2606a64330a29ac00af279bc14331e258bf8f59781ae65387::osail_04dec2025 {
    struct OSAIL_04DEC2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_04DEC2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_04DEC2025>(arg0, 6, b"oSAIL-04Dec2025", b"oSAIL-04Dec2025", b"Full Sail option token, expiration 04 Dec 2025 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_04DEC2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_04DEC2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

