module 0x5e279b19e3fa9ad92a44ff3cb1737a48f587fbd13f42370470e333cc352a6265::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"Candy", b"Suizilla", b"suizilla is a cute monster who loves to eat candy on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1396_e8ae65cc95.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

