module 0xc36f70c77ea506da83a7787af44afd84dfdaf7f4bb80a570dd1a3766c19030e3::sgame {
    struct SGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAME>(arg0, 6, b"SGAME", b"Suid Game", x"5468652067616d65732068617665206f6666696369616c6c79207374617274656421200a0a446f6e27742066616c6c20626568696e64206f7220796f752077696c6c2064696520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12266_ezgif_com_optimize_1_a0939ba6d5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

