module 0xbd7ca15281f855056653f4cc50ea48e75f51bca87a7669fd32fc15983559a562::psuilong {
    struct PSUILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUILONG>(arg0, 6, b"PSUILONG", b"PEPESUILONG", b"Have you already collected 7 SUI in your wallet? Then you are entitled to a wish! For you to release your desire, you need to bump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2_36b2381fdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUILONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUILONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

