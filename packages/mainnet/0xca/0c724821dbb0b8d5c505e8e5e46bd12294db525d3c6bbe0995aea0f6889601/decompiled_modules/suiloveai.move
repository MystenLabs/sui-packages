module 0xca0c724821dbb0b8d5c505e8e5e46bd12294db525d3c6bbe0995aea0f6889601::suiloveai {
    struct SUILOVEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOVEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILOVEAI>(arg0, 6, b"SUILOVEAI", b"SUI LOVE AI by SuiAI", b"SUI LOVE AI is a combination of sui and ai communities based on the rapid development of the sui ecosystem and the increasingly advanced development of the ai world in the crypto world, especially on the $SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/r_S_Fm_LOE_5_Td_KLVG_Mfb7l1_MA_dcc7ab4c63.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILOVEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOVEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

