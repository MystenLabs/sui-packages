module 0xada0ade76fc33a8abd02056e95ccb546467f86c4c7dced6f5eff917a133e99e2::goatsui {
    struct GOATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATSUI>(arg0, 6, b"GOATSUI", b"Goatsuies Maximus", b"THE GOATSUIES - SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000220730_31720499ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

