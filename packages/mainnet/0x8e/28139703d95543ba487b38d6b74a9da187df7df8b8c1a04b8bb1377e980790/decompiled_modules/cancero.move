module 0x8e28139703d95543ba487b38d6b74a9da187df7df8b8c1a04b8bb1377e980790::cancero {
    struct CANCERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANCERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANCERO>(arg0, 6, b"CANCERO", b"Cancero", b"The Guardians of the Sui Galaxy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000398_c185891f8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANCERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANCERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

