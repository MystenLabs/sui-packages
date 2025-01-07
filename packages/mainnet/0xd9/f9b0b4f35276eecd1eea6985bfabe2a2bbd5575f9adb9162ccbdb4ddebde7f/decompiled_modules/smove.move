module 0xd9f9b0b4f35276eecd1eea6985bfabe2a2bbd5575f9adb9162ccbdb4ddebde7f::smove {
    struct SMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOVE>(arg0, 9, b"MOVE", b"MOVE", b"BlueMove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluemove.net/BlueMove_main_logo_RGB-Blue_512.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOVE>>(v0, @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

