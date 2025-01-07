module 0x361147854fcfee899de6e2960c1961349263728f5d8c541342763e3f2f80c22b::tomorow {
    struct TOMOROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMOROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMOROW>(arg0, 9, b"TOMOROW", b"Tomorrow", b"New day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e3ea5b6-62a5-48b0-99c5-9306721dbbf6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMOROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMOROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

