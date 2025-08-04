module 0x1af58255ce892974e6204b202a6d88fe7c0d00ee27ec9f7078ee827572a229bf::scallop_w_wal {
    struct SCALLOP_W_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_W_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_W_WAL>(arg0, 9, b"swWAL", b"swWAL", b"Scallop interest-bearing token for Winter WAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mr25tqwrjxs5drjz4t5wxskbnd3mnh5rrizlhe6cesuop7hyzt2a.arweave.net/ZHXZwtFN5dHFOeT7a8lBaPbGn7GKMrOTwiSo5_z4zPQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_W_WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_W_WAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

