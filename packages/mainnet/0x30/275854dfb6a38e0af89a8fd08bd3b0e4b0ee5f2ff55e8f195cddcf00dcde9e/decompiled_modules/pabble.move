module 0x30275854dfb6a38e0af89a8fd08bd3b0e4b0ee5f2ff55e8f195cddcf00dcde9e::pabble {
    struct PABBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PABBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PABBLE>(arg0, 6, b"PABBLE", b"Pabble The CapyBara", b"Always be yourself unless you can be a Capybara. Then always be a CAPYBARA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048023_8e75208e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PABBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PABBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

