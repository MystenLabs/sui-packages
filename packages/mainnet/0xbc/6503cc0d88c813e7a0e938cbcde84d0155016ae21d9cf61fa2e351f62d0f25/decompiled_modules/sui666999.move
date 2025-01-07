module 0xbc6503cc0d88c813e7a0e938cbcde84d0155016ae21d9cf61fa2e351f62d0f25::sui666999 {
    struct SUI666999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI666999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI666999>(arg0, 6, b"SUI666999", b"SuIntelCore i666999", x"3639204d204b454b4b4b4b452c20416f732049656e206170204936392d3432303030303030305858787858204350555555555520746f6f20362c363647687a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f_f30056db14.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI666999>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI666999>>(v1);
    }

    // decompiled from Move bytecode v6
}

