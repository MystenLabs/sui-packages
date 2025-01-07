module 0x11046cb67b04782708ec4c11b71cc18604c0393c26ab93b6af81b475630c4c0d::peppa {
    struct PEPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPA>(arg0, 6, b"Peppa", b"Peppa Pig", b"the most popular little pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1625720578702_c50948fd2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

