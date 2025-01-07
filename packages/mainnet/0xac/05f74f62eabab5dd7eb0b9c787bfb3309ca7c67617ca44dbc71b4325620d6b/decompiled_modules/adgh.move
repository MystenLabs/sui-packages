module 0xac05f74f62eabab5dd7eb0b9c787bfb3309ca7c67617ca44dbc71b4325620d6b::adgh {
    struct ADGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADGH>(arg0, 6, b"Adgh", b"5236", b"2654", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Valtue_Aktien_warrent_buffett_header_2c48fecd3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

