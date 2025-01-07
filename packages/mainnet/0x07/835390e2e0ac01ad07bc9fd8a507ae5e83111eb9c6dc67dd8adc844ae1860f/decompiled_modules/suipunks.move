module 0x7835390e2e0ac01ad07bc9fd8a507ae5e83111eb9c6dc67dd8adc844ae1860f::suipunks {
    struct SUIPUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUNKS>(arg0, 6, b"SUIPUNKS", b"SUI PUNKSS", x"5355492050554e4b530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_35_5a7d3ff1b6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

