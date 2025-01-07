module 0x40958cc10d495cbb119f2f07684e293cced15928d55467f8549fb1204e9303b8::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"Suits", b"DoginSuit", b"Dog in a suit. This is financial advice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suits_e60ef462ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

