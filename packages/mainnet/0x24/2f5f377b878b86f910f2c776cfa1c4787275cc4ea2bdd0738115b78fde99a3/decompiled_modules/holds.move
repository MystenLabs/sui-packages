module 0x242f5f377b878b86f910f2c776cfa1c4787275cc4ea2bdd0738115b78fde99a3::holds {
    struct HOLDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLDS>(arg0, 6, b"HOLDS", b"Sui Holds Together", b"Hold hold hold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_14_T225503_360_58a9c824a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

