module 0x652b90f2dd9c2fe7e6917b2b129ecf45ea4134a6d2d419f3c43e7dd2a40990f1::babycapy {
    struct BABYCAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCAPY>(arg0, 6, b"BabyCapy", b"BabyCapybara", b"Just a meme of Capybara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7122b9872fcdbca4b50ecdae89cee085_c882d171b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYCAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

