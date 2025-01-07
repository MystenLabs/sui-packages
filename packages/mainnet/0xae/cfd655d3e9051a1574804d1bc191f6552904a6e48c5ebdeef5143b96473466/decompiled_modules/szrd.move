module 0xaecfd655d3e9051a1574804d1bc191f6552904a6e48c5ebdeef5143b96473466::szrd {
    struct SZRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZRD>(arg0, 6, b"SZRD", b"Suizard", b"\"Fin-tastic spells ahead, but first, let me school you!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suizard_78f266766e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

