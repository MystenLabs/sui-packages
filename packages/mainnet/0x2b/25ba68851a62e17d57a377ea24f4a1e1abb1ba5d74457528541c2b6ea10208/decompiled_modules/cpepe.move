module 0x2b25ba68851a62e17d57a377ea24f4a1e1abb1ba5d74457528541c2b6ea10208::cpepe {
    struct CPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPEPE>(arg0, 6, b"CPEPE", b"Curry Pepe", x"506570652068617320636f6f6b656420746865206d6f7374206d61676963616c2024435045504520696e2074686520776f726c642077686963682067617665206d7973746963616c20706f77657273206f66206c75636b2026207765616c746820746f2074686f73652077686f2061726520776f7274687920656e6f75676820746f2066696e642069742e0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_a3cd001ff8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

