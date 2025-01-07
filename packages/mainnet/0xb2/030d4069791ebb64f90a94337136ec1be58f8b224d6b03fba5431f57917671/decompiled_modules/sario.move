module 0xb2030d4069791ebb64f90a94337136ec1be58f8b224d6b03fba5431f57917671::sario {
    struct SARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARIO>(arg0, 6, b"SARIO", b"Sui Mario", b"Introducing Sui Mario ($SUIMARIO)  The ultimate plumber has found his way to the Sui network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_56_1_0f00d58a8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

