module 0x7ea46e7d41213841344dd1df3631347c0b677434c61baace2c50546a2e358c35::suidoai {
    struct SUIDOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIDOAI>(arg0, 6, b"SUIDOAI", b"Dog by SuiAI", b"SUIDOAI fun pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0x41636c138167952207c88f5a75e433c9e880bc7bd5e4e46047d82be266d36712_dak_dak_bb40f75de1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

