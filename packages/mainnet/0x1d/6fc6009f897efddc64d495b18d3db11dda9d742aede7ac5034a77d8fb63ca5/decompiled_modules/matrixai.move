module 0x1d6fc6009f897efddc64d495b18d3db11dda9d742aede7ac5034a77d8fb63ca5::matrixai {
    struct MATRIXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRIXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MATRIXAI>(arg0, 6, b"MATRIXAI", b"Matrix Oracle by SuiAI", b"Matrix Oracle: The 1st AI agent crafting evolving, user-shaped stories for a personalized, immersive experience built on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/X7_J_Dlm2_X_400x400_4f9f88056e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MATRIXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

