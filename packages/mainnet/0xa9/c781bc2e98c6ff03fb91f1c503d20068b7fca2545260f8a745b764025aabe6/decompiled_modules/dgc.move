module 0xa9c781bc2e98c6ff03fb91f1c503d20068b7fca2545260f8a745b764025aabe6::dgc {
    struct DGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGC>(arg0, 6, b"DGC", b"DogeCoin", b"8092000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241110213706_5ab79f2e20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

