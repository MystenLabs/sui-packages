module 0x1efc447a8af906ee8fe785053150d5a310e8a3e51e84c385e68134fb608b2b98::meyo {
    struct MEYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEYO>(arg0, 6, b"MEYO", b"Sui Meyo", b"MEYO JUST MEYO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055095_cd71c4f3f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

