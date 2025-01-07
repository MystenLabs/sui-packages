module 0x75840d3af532540c8e5c2fd14c66ef3046a7ea81f41c8176e3c44bf476a3867f::muza {
    struct MUZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUZA>(arg0, 9, b"MUZA", b"Muzaratti", b"A unique name comes from nowhere ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46fa55bd-ffa3-45b9-872a-3f2a25267675.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

