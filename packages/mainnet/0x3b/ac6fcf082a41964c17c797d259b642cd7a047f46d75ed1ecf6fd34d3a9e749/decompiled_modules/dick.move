module 0x3bac6fcf082a41964c17c797d259b642cd7a047f46d75ed1ecf6fd34d3a9e749::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 6, b"DICK", b"DICK SUI", b"BIG DICK ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0iaje_x_O_400x400_7632d91bad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

