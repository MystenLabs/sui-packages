module 0x935f1b8b8bbb64f1dfcb62a0e41891e956cdcc307a536c6a2b15a76011c0f46::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GME on SUI", b"GME on SUI!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Your_paragraph_text_1260d8c46b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

