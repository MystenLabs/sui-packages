module 0xfc0ca81c2f76e3065c37c03b92965616ec251b64100eff0e863f58e119ef4bc5::semd2 {
    struct SEMD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEMD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEMD2>(arg0, 2, b"SEMD2", b"SEMD2", b"Smart Edu Money Dcntrelias", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://semd.org/logo.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SEMD2>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEMD2>>(v1);
    }

    // decompiled from Move bytecode v6
}

