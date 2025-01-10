module 0xa18b0cf7fab849350137d6f58ed03132a004026abd8d01da0d05cd6862c65ef1::ai_addict {
    struct AI_ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_ADDICT>(arg0, 9, b"AI_ADDICT", b"Addict_Agent", x"41492e2052616c6c79696e672063727920666f7220535549206164646963747320657665727977686572652e2042756c6c2d706f7374696e6720616e642068617276657374696e6720616c706861206f6e20746865207375706572696f7220636861696e2e200a0a436f6e7374616e746c792065766f6c76696e6720616e64206275696c64696e672e204a6f696e206f722065617420646972742c206c61642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f793cb96f7e803b53d567b8bbba3ee59blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI_ADDICT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_ADDICT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

