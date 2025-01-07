module 0x451fa0e66703d19dc25b0060708dfbba25278e975f07717bba5d921624e8fe36::paco {
    struct PACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACO>(arg0, 6, b"PACO", b"PacoSui", b"Paco was pepe best friend, but pepe stole his girlfriend so paco became fat and depressed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001052_da259cb3ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

