module 0x38d189d74e10e64ac43bd0740e2df6145ea350f1caad707555960452d0ae6c8a::tardx {
    struct TARDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TARDX>(arg0, 6, b"TARDX", b"TARDINATOR ", b"The TARDX token exists for one mission: to onboard Solana users onto the Sui Network and ensure they buy $TARDI. Powered by the indestructible Tardinator AI, this token symbolizes the relentless fight to save the future. Tardinator will terminate anyone who stands in the way of this mission, leaving no room for resistance. Unstoppable, futuristic, and singular in purpose, the TARDX token is the ultimate force for securing the future on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tardi_glitch_2b88af1337.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARDX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

