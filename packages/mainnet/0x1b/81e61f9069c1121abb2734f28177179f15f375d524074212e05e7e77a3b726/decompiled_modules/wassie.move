module 0x1b81e61f9069c1121abb2734f28177179f15f375d524074212e05e7e77a3b726::wassie {
    struct WASSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASSIE>(arg0, 6, b"WASSIE", b"Whompwassie", b"Global Wassification through $WASSIE utilizing the Potency of Memetic Energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038904_5fc88e45b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

