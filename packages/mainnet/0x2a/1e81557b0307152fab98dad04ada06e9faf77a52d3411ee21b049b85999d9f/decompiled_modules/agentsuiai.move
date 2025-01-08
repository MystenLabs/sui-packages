module 0x2a1e81557b0307152fab98dad04ada06e9faf77a52d3411ee21b049b85999d9f::agentsuiai {
    struct AGENTSUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTSUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTSUIAI>(arg0, 6, b"AGENTSUIAI", b"Agent sui ai", b"our team and ai agent market potential expanding and we are ready to make this year of sui and AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736311697483.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENTSUIAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTSUIAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

