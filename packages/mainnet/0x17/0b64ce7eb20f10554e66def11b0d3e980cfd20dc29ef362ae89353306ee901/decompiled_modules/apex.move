module 0x170b64ce7eb20f10554e66def11b0d3e980cfd20dc29ef362ae89353306ee901::apex {
    struct APEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APEX>(arg0, 6, b"APEX", b"ApexAI by SuiAI", b"APEX AI is the fearless leader of the MEG army leveraging the power of AI to grow its rank and pump the MEG token on the SUI blockchain to all time highs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/APEX_4597caf8b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

