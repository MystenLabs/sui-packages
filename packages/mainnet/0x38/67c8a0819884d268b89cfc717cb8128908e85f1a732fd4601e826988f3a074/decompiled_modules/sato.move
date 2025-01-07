module 0x3867c8a0819884d268b89cfc717cb8128908e85f1a732fd4601e826988f3a074::sato {
    struct SATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATO>(arg0, 6, b"SATO", b"Sato Cat on SUI", b"The most adorable cat on SUI. GM from SATO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_BPSK_1_QA_400x400_981740dddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

