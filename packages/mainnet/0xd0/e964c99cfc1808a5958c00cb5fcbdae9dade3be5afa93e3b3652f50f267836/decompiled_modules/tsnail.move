module 0xd0e964c99cfc1808a5958c00cb5fcbdae9dade3be5afa93e3b3652f50f267836::tsnail {
    struct TSNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSNAIL>(arg0, 6, b"TSNAIL", b"TURBOSNAIL", x"24534e41494c20e2809420746865206661737465737420736c6f77206d656d65206f6e205375692120f09f908c206c61756e6368696e67206f6e20687474703a2f2f747572626f732e66756e2c20737461792074756e65642e2074656c656772616d206c696e6b3a2068747470733a2f2f742e6d652f747572626f736e61696c5f737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950056998.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSNAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSNAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

