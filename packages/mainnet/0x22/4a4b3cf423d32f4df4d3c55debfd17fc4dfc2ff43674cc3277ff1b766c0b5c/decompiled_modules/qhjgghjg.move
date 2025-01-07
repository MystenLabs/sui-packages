module 0x224a4b3cf423d32f4df4d3c55debfd17fc4dfc2ff43674cc3277ff1b766c0b5c::qhjgghjg {
    struct QHJGGHJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: QHJGGHJG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QHJGGHJG>(arg0, 9, b"QHJGGHJG", b"jkkhj", b"jhghjgjhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98e9f839-9fc9-4bb9-a46d-428978c685ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QHJGGHJG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QHJGGHJG>>(v1);
    }

    // decompiled from Move bytecode v6
}

