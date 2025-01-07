module 0xab1d9fc5debba8c158ad44518a55c712c75a34895ce314ade350035d1c2c505::buss {
    struct BUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSS>(arg0, 6, b"BUSS", b"Bubble", b"Bubble has arrived to take over the seven seas of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0784_e09210ff7b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

