module 0xe01a7bfab6881b36c7fcb2c2e34abefbaf72185750e464ea2b51a793ce3ffea6::fffp {
    struct FFFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FFFP>(arg0, 6, b"FFFP", b"Pr0g4M3r by SuiAI", x"4966207265616c206c6966652077657265206120737065656472756e2c20796f75e280996420646f6d696e61746520746865204e6f20417474656d7074732063617465676f72792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_10_30_24_Ein_futuristischer_Roastbot_Pro_Gamer_ein_humanoider_Roboter_mit_High_Tech_Gaming_Ausruestung_Der_Roastbot_hat_ein_schlankes_metallisches_Design_mit_52faee87f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FFFP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

