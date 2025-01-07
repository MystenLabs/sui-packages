module 0x293b33b8c7343627e54cafed4752f48fb271b23511285c3cde5d70dffdbe1a35::sgame {
    struct SGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAME>(arg0, 6, b"SGAME", b"Suid Game", x"5468652067616d65732068617665206f6666696369616c6c7920737461727465642120446f6e27742066616c6c20626568696e64206f7220796f752077696c6c206469650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735423214292.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

