module 0x72f344ea2d7983765141a0929f290ff87f3f6b6949954619ded8b3c94cf6d703::voxa {
    struct VOXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOXA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VOXA>(arg0, 6, b"VOXA", b"Voxa AI by SuiAI", b"sui revolutionary language AI that facilitates seamless communication and empowers people with intelligent, language-based tools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000021451_9fca62ecdb_133c843616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOXA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOXA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

