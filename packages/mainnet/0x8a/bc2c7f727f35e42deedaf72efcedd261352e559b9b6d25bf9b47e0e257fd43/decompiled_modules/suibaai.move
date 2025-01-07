module 0x8abc2c7f727f35e42deedaf72efcedd261352e559b9b6d25bf9b47e0e257fd43::suibaai {
    struct SUIBAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAAI>(arg0, 6, b"SuibaAI", b"Suiba AI", b"SuibaAI aims to drive wider adoption of AI technology and accelerate the development of AI-based solutions in various industries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732360448425.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBAAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

