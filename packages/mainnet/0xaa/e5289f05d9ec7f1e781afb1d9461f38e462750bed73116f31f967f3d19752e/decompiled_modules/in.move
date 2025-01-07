module 0xaae5289f05d9ec7f1e781afb1d9461f38e462750bed73116f31f967f3d19752e::in {
    struct IN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IN>(arg0, 6, b"IN", b"In", b"in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_24_110434_5d034b00bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IN>>(v1);
    }

    // decompiled from Move bytecode v6
}

