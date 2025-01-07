module 0xb266d04f099b6c45bb16ef9e194e3b759c4bcc583d4c4677838ace1d8e1ed7e7::krill {
    struct KRILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRILL>(arg0, 6, b"KRILL", b"KRILLIONS", b"KRILLIONS. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KRILL_61af3bd098.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

