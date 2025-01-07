module 0x2966e6fa02a45dabdc9df8938b13581333f202df4aa4d92701b470793d4c8e4e::holiday {
    struct HOLIDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLIDAY>(arg0, 9, b"HOLIDAY", b"HolidayTK", b"Holiday Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d31787b-473d-4484-925c-b22b43e452c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLIDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLIDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

