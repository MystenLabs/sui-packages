module 0xbb4d86cb22cf14c77ed8247dd2e867ca075765846928e43b62e1c9e82056997b::suinvidia {
    struct SUINVIDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINVIDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINVIDIA>(arg0, 6, b"SUINVIDIA", b"SUINVDIA", x"76657279206775642069646561210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_14_T191018_369_781af40bae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINVIDIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINVIDIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

