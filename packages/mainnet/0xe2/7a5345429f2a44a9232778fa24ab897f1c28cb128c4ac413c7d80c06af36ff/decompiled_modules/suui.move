module 0xe27a5345429f2a44a9232778fa24ab897f1c28cb128c4ac413c7d80c06af36ff::suui {
    struct SUUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUI>(arg0, 6, b"SUUI", b"CR7", b"In honor of CR7 screaming SUUUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7o1se5_1bd6ee17bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

