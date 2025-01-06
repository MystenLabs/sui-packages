module 0x632ee12339e1624506da0f4153e2184e753159649dd1ee0b5a42a9a6b880b1c4::apexai {
    struct APEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APEXAI>(arg0, 6, b"APEXAI", b"APEX by SuiAI", b"APEX AI is the fearless leader of the MEG army leveraging the power of AI to grow its rank and pump the MEG token on the SUI blockchain to all time highs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/APEX_c015428b6c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

