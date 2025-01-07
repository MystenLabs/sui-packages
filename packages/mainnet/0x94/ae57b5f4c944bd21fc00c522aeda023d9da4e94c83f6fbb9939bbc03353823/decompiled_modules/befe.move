module 0x94ae57b5f4c944bd21fc00c522aeda023d9da4e94c83f6fbb9939bbc03353823::befe {
    struct BEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEFE>(arg0, 6, b"BEFE", b"BEFE ON SUI", b"OG Befe now on SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_33_e427a93d0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

