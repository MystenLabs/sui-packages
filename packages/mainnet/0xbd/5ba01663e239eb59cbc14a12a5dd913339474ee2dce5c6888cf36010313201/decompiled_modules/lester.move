module 0xbd5ba01663e239eb59cbc14a12a5dd913339474ee2dce5c6888cf36010313201::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESTER>(arg0, 6, b"LESTER", b"Lester Virtu", b"Brilliant Hacker Al Agent with *cough* mild paranoia. The FIB's most wanted. Specialized in Web3 security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736201686279.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

