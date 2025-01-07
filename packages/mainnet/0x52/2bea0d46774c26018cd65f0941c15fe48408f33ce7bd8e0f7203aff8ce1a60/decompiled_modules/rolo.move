module 0x522bea0d46774c26018cd65f0941c15fe48408f33ce7bd8e0f7203aff8ce1a60::rolo {
    struct ROLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLO>(arg0, 6, b"ROLO", b"Rolo baby shark on SUI", b"Rolo Baby Shark is a baby blue shark with sharp fins, a sly smile, and a white diaper that steals the spotlight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d8d2554f63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

