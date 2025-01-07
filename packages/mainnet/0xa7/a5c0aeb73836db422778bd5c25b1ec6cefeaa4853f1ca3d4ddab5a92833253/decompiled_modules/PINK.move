module 0xa7a5c0aeb73836db422778bd5c25b1ec6cefeaa4853f1ca3d4ddab5a92833253::PINK {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 9, b"ELON", b"Pink Elon", b"Pink Elon Ruzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4_2a8ZsK0ec-A7FvREq-8-0E5Q2a-wYUC8w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

