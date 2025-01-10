module 0x3938e8ef1997debd1607c44e2b300637cc3f751d4e8df3d8ef3edf8019fda30a::addict {
    struct ADDICT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDICT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADDICT>(arg0, 6, b"ADDICT", b"Addict AI by SuiAI", b"Constantly evolving and building AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1_Dq_HI_Jze_400x400_f5e72f6191.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADDICT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDICT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

