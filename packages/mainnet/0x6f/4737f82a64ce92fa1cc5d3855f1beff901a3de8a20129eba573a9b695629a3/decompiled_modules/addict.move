module 0x6f4737f82a64ce92fa1cc5d3855f1beff901a3de8a20129eba573a9b695629a3::addict {
    struct ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADDICT>(arg0, 6, b"ADDICT", b"Addict AI by SuiAI", b"Constantly evolving and building AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1_Dq_HI_Jze_400x400_49cc448ee7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADDICT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDICT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

