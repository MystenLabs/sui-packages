module 0xeb17c65ae85ed2a2c780279282260e829a009e947e3287271a351a7fe704027b::hczsn3 {
    struct HCZSN3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCZSN3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCZSN3>(arg0, 9, b"Hczsn3", b"hczsnnn3", b"third", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d50e3478c407551d04ab9bbd1348f18ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCZSN3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCZSN3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

