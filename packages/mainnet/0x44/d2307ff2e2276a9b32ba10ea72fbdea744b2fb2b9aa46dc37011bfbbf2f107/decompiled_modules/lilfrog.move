module 0x44d2307ff2e2276a9b32ba10ea72fbdea744b2fb2b9aa46dc37011bfbbf2f107::lilfrog {
    struct LILFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILFROG>(arg0, 6, b"LILFROG", b"Lilfrog", x"43727970746f2069736e742061626f7574206368617274732e204974732061626f75742073796d626f6c732e0a57652072616c6c792061726f756e6420696d616765732c2069646561732c20616e6420656e657267792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062996_d30fb21756.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

