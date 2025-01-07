module 0x673a6b9bfc0b938642bb248b2d0ff4c8a3923db27ba769494af9fba46c6e7894::suidmnd {
    struct SUIDMND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDMND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDMND>(arg0, 6, b"SUIDMND", b"The Sui Diamond", b"The \"Suinigma\"  is the largest polished blue diamond in the world and its on Sui. Richard Heart is thinking of moving over to Sui, because of this. This Diamond will reach even higher than 4.3m$.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/The_Sui_Diamond_1_71ad9205b5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDMND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDMND>>(v1);
    }

    // decompiled from Move bytecode v6
}

