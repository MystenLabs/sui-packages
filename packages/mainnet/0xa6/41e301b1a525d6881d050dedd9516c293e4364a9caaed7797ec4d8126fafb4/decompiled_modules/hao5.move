module 0xa641e301b1a525d6881d050dedd9516c293e4364a9caaed7797ec4d8126fafb4::hao5 {
    struct HAO5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAO5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAO5>(arg0, 6, b"HAO5", b"HAO005", b"005", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sK2hLjvYm532uVlLdy30bSd7ieMWLtIzKA&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAO5>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAO5>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAO5>>(v2);
    }

    // decompiled from Move bytecode v6
}

