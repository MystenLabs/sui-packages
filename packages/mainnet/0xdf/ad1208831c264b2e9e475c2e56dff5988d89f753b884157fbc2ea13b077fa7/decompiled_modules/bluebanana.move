module 0xdfad1208831c264b2e9e475c2e56dff5988d89f753b884157fbc2ea13b077fa7::bluebanana {
    struct BLUEBANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBANANA>(arg0, 6, b"BLUEBANANA", b"Blue Banana", b"This is rare blue banana, hodl and you will become bananillionaire, ignore and you will fail forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0296_e1df670a4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEBANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

