module 0x2ba4b18fdcf84332a0822123422d1cf9d2ed499ff640309da17b7137fe7e1a71::hottie {
    struct HOTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTTIE>(arg0, 6, b"HOTTIE", b"Hottie Froggie", b"Hottie the meme coin On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015590_d01d6acc1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

