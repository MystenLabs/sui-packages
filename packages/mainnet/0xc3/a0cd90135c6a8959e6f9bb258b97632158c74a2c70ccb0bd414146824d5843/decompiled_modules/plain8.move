module 0xc3a0cd90135c6a8959e6f9bb258b97632158c74a2c70ccb0bd414146824d5843::plain8 {
    struct PLAIN8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAIN8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAIN8>(arg0, 9, b"PLAIN8", b"Plain card", b"Utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/239ee1fd-167e-4c37-b107-4395a8ec6016.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAIN8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLAIN8>>(v1);
    }

    // decompiled from Move bytecode v6
}

