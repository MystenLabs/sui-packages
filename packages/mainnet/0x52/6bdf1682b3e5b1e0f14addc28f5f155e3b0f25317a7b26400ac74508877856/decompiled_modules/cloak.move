module 0x526bdf1682b3e5b1e0f14addc28f5f155e3b0f25317a7b26400ac74508877856::cloak {
    struct CLOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOAK>(arg0, 6, b"Cloak", b"CloakPay", b"CloakPay is the premier privacy protocol on Sui, featuring a native wallet extension for secure, non-custodial asset management. Using stealth addresses, we offer a complete ecosystem for anonymous and encrypted financial transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1767555231379.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

