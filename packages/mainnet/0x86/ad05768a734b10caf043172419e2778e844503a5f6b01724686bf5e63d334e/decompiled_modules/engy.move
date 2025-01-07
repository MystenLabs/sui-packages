module 0x86ad05768a734b10caf043172419e2778e844503a5f6b01724686bf5e63d334e::engy {
    struct ENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGY>(arg0, 9, b"ENGY", b"ENERGY ", b"Free energy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09121ce5-2f5d-479c-a10f-34501d510822.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

