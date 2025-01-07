module 0x40b7c200245cef9dda6c1acf75e9129db8e8a1f9a077e03df8f6645377217504::psuilong {
    struct PSUILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUILONG>(arg0, 6, b"PSUILONG", b"PESUILONG", b"Have you already collected 7 SUI in your wallet?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2_5bcb45506b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUILONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUILONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

