module 0xa42534cb4fbba4e700c8b1092f8dc2c9b3350d3a859194c3875d53646d07e1f8::bkieu02 {
    struct BKIEU02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKIEU02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKIEU02>(arg0, 9, b"BKIEU02", b"Bang02", b"Air02", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44b580b2-d6c9-4170-bb15-9982d3dc238b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKIEU02>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKIEU02>>(v1);
    }

    // decompiled from Move bytecode v6
}

