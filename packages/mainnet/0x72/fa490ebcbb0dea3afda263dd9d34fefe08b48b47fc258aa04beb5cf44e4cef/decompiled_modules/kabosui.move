module 0x72fa490ebcbb0dea3afda263dd9d34fefe08b48b47fc258aa04beb5cf44e4cef::kabosui {
    struct KABOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSUI>(arg0, 6, b"KABOSUI", b"KABOSUI TOKEN", x"596f752063616e2063616c6c20796f757273656c66206c75636b7920746f2062652070617274206f6620746865206669727374204b61626f7375206f6e205355492063616c6c6564204b41424f535549210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kabosui_04d0182e8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

