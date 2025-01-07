module 0x55e28eb4bb1a3a0bd697fa442fa9e93c9ed00baac14ab75b5cc25c0080c2e7e8::suisungglxy {
    struct SUISUNGGLXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUNGGLXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUNGGLXY>(arg0, 6, b"SUISUNGGLXY", b"SUISUNG GALAXY", b"We just got Suisung-ed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_74_37779d49c0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUNGGLXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUNGGLXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

