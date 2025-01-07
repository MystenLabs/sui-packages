module 0xa8592efbe48452d1deec82f2766b01534662e69390c7f3482dd446578c8e92c7::movepump {
    struct MOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPUMP>(arg0, 6, b"MOVEPUMP", b"MovePump2.0", x"546865204669727374204d656d652046616972204c61756e636820506c6174666f726d206f6e20535549204e6574776f726b0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_30_15_50_18_225468e896.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

