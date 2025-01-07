module 0xb011dfc4103a8ab0bb9ae5604cdc32269f3f9db8c554f1f3f5b829244b244d6e::sucy {
    struct SUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCY>(arg0, 6, b"SUCY", b"SUCY TOKEN", b"SUCY girl, the main representative of the SUI ecosystem, only the SUI blockchain has her in its entirety.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734270595245.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

