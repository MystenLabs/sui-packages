module 0xf4a1f2602c182cba39af48ed0e410267340536c01a2b55c2a94b54d4376dccba::tank {
    struct TANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANK>(arg0, 6, b"Tank", b"CryptoPanzer", x"4461726520746f206c65616420e28094206675656c207468652066757475726520776974682054616e6b2c2074686520626f6c64207374657020696e746f20646563656e7472616c697a656420706f7765722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746114468316.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TANK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

