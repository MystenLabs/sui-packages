module 0x30cd82e5c90e7a180d4fb65e5ebd211b76d454d5a6bff8a6a3bb69882aecbe6b::homosexuarrr {
    struct HOMOSEXUARRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMOSEXUARRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMOSEXUARRR>(arg0, 9, b"HOMO", b"homosexuarrr", b"Homosexuarrr boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/ff3ff29c-d084-4c9d-9954-0280c0e97995.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMOSEXUARRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMOSEXUARRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

