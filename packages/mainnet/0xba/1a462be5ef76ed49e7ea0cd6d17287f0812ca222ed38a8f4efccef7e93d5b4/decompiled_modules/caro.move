module 0xba1a462be5ef76ed49e7ea0cd6d17287f0812ca222ed38a8f4efccef7e93d5b4::caro {
    struct CARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARO>(arg0, 6, b"CARO", b"CapyRock", b"Rock rock I make stock. Small start to the moon baby Capybara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67d353d66c9ee71a193696006388787d_92c43f8077.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

