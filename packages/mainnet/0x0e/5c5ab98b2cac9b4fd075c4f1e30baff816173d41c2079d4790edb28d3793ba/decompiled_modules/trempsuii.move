module 0xe5c5ab98b2cac9b4fd075c4f1e30baff816173d41c2079d4790edb28d3793ba::trempsuii {
    struct TREMPSUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMPSUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMPSUII>(arg0, 6, b"Trempsuii", b"Tremp Sui", b"Donald Trump on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9239_6783d13240.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMPSUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMPSUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

