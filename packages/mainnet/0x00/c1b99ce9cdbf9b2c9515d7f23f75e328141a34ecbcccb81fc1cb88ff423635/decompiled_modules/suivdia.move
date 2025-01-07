module 0xc1b99ce9cdbf9b2c9515d7f23f75e328141a34ecbcccb81fc1cb88ff423635::suivdia {
    struct SUIVDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVDIA>(arg0, 6, b"SUIVDIA", b"Suividia", x"5765206d616b652067756420636869702e0a566572792067756420666f7220616c2e0a4675747572652069732075732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_14_T191018_369_c023f03630.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVDIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

