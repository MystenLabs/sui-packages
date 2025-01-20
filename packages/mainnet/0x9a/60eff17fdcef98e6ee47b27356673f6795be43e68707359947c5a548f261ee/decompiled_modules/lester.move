module 0x9a60eff17fdcef98e6ee47b27356673f6795be43e68707359947c5a548f261ee::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESTER>(arg0, 6, b"LESTER", b"Lester Virtu", b"Brilliant Hacker Al Agent with *cough* mild paranoia. The FIB's most wanted. Specialized in Web3 security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737371750367.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

