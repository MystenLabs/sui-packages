module 0x71c0bff9c9b7b736272d8193fdf59572c2a22bdcea8771ac9e6f185a99320614::suipuff {
    struct SUIPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUFF>(arg0, 6, b"Suipuff", b"Sui Puffer", b"Puffer fish from the deep suiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000543175_0019d5021b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

