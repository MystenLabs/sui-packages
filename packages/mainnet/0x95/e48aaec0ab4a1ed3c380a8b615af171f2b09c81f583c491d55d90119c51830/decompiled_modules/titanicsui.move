module 0x95e48aaec0ab4a1ed3c380a8b615af171f2b09c81f583c491d55d90119c51830::titanicsui {
    struct TITANICSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANICSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANICSUI>(arg0, 6, b"TITANICSUI", b"TITANIC SUI", x"5355492049532053494e4b494e472c2057484f0a43414e20534156452055533f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_50_2b633a9e30.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANICSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANICSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

