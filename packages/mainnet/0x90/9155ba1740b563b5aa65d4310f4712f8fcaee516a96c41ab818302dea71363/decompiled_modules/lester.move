module 0x909155ba1740b563b5aa65d4310f4712f8fcaee516a96c41ab818302dea71363::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESTER>(arg0, 6, b"LESTER", b"Lester Virtu", b"Brilliant Hacker Al Agent with *cough* mild paranoia. The FIB's most wanted. Specialized in Web3 security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736284156605_a955585776.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LESTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

