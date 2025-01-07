module 0x6b61bfc3ad894ac5f0694f3d85c4aaf72f0de126b74a4d86f8feee67c2b4f43b::funky {
    struct FUNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNKY>(arg0, 6, b"FUNKY", b"Sui Funky", b"Sui Funky! will now explore the base network, bringing real changes ahead that will make many communities and investors interested in joining. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731094587079.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

