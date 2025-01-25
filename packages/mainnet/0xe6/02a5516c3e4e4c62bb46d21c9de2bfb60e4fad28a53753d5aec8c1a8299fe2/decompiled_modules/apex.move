module 0xe602a5516c3e4e4c62bb46d21c9de2bfb60e4fad28a53753d5aec8c1a8299fe2::apex {
    struct APEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APEX>(arg0, 6, b"APEX", b"Apex Alpha AI by SuiAI", b"Apex Alpha is an AI-powered trading bot designed to deliver data-driven signals for long and short positions in the crypto market to achieve consistent gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RW_2m4_Obq_400x400_ce5b94dd2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

