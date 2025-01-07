module 0x588a44c1fff188b850d2a18a392df360a4a16ceef44623614bdf95701538250a::bigkinonic {
    struct BIGKINONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGKINONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGKINONIC>(arg0, 9, b"BIGKINONIC", b"Banbs", x"4920646f6ee2809974206861766520737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44499e5c-c1bf-42d5-938d-e25ac1d35450.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGKINONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGKINONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

