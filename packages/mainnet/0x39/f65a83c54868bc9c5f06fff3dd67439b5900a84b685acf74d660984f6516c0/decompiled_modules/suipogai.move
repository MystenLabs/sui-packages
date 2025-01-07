module 0x39f65a83c54868bc9c5f06fff3dd67439b5900a84b685acf74d660984f6516c0::suipogai {
    struct SUIPOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOGAI>(arg0, 6, b"SUIPOGAI", b"SUI POGAI", b"POGAI ON SUi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pogai_57ee14393b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

