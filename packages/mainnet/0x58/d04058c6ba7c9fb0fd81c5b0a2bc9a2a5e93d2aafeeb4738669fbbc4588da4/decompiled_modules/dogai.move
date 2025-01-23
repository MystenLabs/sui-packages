module 0x58d04058c6ba7c9fb0fd81c5b0a2bc9a2a5e93d2aafeeb4738669fbbc4588da4::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGAI>(arg0, 6, b"DOGAI", b"Dog Terminator by SuiAI", b"The Dog Terminator is your most loyal friend sent back to you from your dying self to make sure you have the best life ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dog_terminator_f509f1bcb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

