module 0xe044663470505c6b0d50af50629757430c4a0c70938e723e499aabdd745a83f3::shoa {
    struct SHOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOA>(arg0, 9, b"SHOA", b"SUIHOA", x"73756920686f612068e1bb936e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd43617f-165b-482d-85c4-d1a7e3236873.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

