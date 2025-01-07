module 0x91f00c0ec5056bbc26bd36e8949385b234051f66bdc420fefc52f569e3bc633d::suitardio {
    struct SUITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARDIO>(arg0, 6, b"SUITARDIO", b"SUITARDIO XP", x"626f6f74696e67207375696e646f77732c20706c6561736520776169742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_11_T141523_464_0cfc721bea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

