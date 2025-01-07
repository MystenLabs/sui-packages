module 0xd5f78941761150c815d9726b518b6010d1d4fd818e245d64c99596dd4529aa9::clfllfl {
    struct CLFLLFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLFLLFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLFLLFL>(arg0, 9, b"CLFLLFL", b"Siskks", b"Dodksj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/000ec957-2337-4a65-86f3-268ef237c2c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLFLLFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLFLLFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

