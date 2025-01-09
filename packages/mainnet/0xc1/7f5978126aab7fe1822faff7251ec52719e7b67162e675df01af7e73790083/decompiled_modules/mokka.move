module 0xc17f5978126aab7fe1822faff7251ec52719e7b67162e675df01af7e73790083::mokka {
    struct MOKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKKA>(arg0, 6, b"MOKKA", b"Sui Mokka", b"$MOKKA Sippin on coffe all days is what we do", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022543_1811f33e15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

