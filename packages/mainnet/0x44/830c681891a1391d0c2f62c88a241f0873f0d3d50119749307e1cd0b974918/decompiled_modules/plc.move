module 0x44830c681891a1391d0c2f62c88a241f0873f0d3d50119749307e1cd0b974918::plc {
    struct PLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLC>(arg0, 9, b"PLC", b"bird_core", b"protect renewable energy RWA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a847aaf3e98421c9ee7542823670375ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

