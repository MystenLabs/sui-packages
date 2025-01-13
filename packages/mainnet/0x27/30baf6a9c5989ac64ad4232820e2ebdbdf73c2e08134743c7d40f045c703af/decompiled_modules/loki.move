module 0x2730baf6a9c5989ac64ad4232820e2ebdbdf73c2e08134743c7d40f045c703af::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 6, b"LOKI", b"Suiloki", b"A dog with aimed to create  a powerful community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042968_d8d0c43d29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

