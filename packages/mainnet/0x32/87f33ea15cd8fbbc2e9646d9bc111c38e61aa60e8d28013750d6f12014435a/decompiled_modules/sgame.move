module 0x3287f33ea15cd8fbbc2e9646d9bc111c38e61aa60e8d28013750d6f12014435a::sgame {
    struct SGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAME>(arg0, 6, b"SGAME", b"Suid Game", x"5468652067616d65732068617665206f6666696369616c6c79207374617274656421200a0a446f6e27742066616c6c20626568696e64206f7220796f752077696c6c20646965200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b0b508378815c71b4790ff4e6e5a8694_2_2bc07f0842.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

