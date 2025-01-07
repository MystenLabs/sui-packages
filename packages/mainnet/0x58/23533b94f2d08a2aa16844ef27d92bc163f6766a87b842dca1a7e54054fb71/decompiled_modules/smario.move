module 0x5823533b94f2d08a2aa16844ef27d92bc163f6766a87b842dca1a7e54054fb71::smario {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARIO>(arg0, 6, b"SMARIO", b"SUI MARIO", b"Remember the iconic Super Mario game from your childhood? Now it's back with a twist, as SUI Mario Token is ready to take over the SUI crypto market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AVATARFINAL_358f3d2e78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

