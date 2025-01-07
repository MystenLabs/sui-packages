module 0x28b983e103301d6f8221f2e3c706aba9119c07c2172de13357e0b4123f96ffcf::bolts {
    struct BOLTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLTS>(arg0, 6, b"BOLTS", b"Bolt Sui", b"Dexscreener Paid.Check now: https://www.boltonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_2_3e29374e42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

