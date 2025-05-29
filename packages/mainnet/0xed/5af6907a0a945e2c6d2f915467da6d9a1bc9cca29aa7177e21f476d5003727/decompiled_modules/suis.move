module 0xed5af6907a0a945e2c6d2f915467da6d9a1bc9cca29aa7177e21f476d5003727::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"Suishi", b"See you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000080978_59dff7b7e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

