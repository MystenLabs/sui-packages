module 0x47425310ceca9a9ec4b2e93fd252e3cfc2a35b11de4eb936a824c62ae9217db9::aia001 {
    struct AIA001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIA001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIA001>(arg0, 6, b"AIA001", b"Registro AIA-001", x"4861736820504446205348413235363a20323642413941394643413543383536363641453742393545364239393232373442313542414643333335314234313742323346444444344645464331313235440a090a566964656f3a2068747470733a2f2f796f7574752e62652f44394a3666454a7161344d0a090a446174613a2030382f30362f32303235", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749409145771.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIA001>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIA001>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

