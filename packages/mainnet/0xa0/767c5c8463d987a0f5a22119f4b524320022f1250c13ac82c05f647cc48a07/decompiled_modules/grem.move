module 0xa0767c5c8463d987a0f5a22119f4b524320022f1250c13ac82c05f647cc48a07::grem {
    struct GREM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREM>(arg0, 6, b"Grem", b"Gremlinz", b"gremlinz is the first meme token that will soon go to the moon whoever holds gremlinz is the winner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240929_084145_262_9bbf4b7b84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREM>>(v1);
    }

    // decompiled from Move bytecode v6
}

