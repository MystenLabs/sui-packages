module 0x74ea0f6416c46b362d625b89760974f58a6dbedcc161923866ebad2da0797dbc::sucks {
    struct SUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCKS>(arg0, 9, b"SUCKS", b"WAVE", b"Go ahead and send me your ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce13b65a-d64b-4d39-b5cf-f3991b88a0ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

