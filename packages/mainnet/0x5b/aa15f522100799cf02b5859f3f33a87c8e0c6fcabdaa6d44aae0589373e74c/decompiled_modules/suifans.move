module 0x5baa15f522100799cf02b5859f3f33a87c8e0c6fcabdaa6d44aae0589373e74c::suifans {
    struct SUIFANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFANS>(arg0, 6, b"SUIfans", b"SUI Fans", b"The only token for SUI fans... ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_Fans_0b8a315d8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

