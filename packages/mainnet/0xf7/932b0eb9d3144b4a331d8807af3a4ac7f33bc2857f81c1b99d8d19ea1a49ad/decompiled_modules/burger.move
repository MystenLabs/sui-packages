module 0xf7932b0eb9d3144b4a331d8807af3a4ac7f33bc2857f81c1b99d8d19ea1a49ad::burger {
    struct BURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURGER>(arg0, 6, b"BURGER", b"BURGER by Trump", b"Introducing \"Trump's Crypto Burger\"  making headlines as he references his first-ever purchase of burgers using Bitcoin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x0c2e08e459fc43ddd1e2718c122f566473f59665_ae024d431b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

