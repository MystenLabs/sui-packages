module 0x62ecbe99c48da6ec3572bc44b22a078e4e08aba1e1115c0d9306ee1275e10af8::cwmn {
    struct CWMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWMN>(arg0, 9, b"CWMN", b"CATWOMAN", b"FOR CATWOMAN FANS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37000424-849d-47ad-ad41-3230389c4c19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

