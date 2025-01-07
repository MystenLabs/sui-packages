module 0x7e634e63e2dc8969e0b80a72ee2959a156625ee2f910956e4c0d68ecbfda4caf::ownd {
    struct OWND has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWND>(arg0, 9, b"OWND", b"hdjd", b"hdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15fffae5-3a46-4082-b1c4-eb966dbd23f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWND>>(v1);
    }

    // decompiled from Move bytecode v6
}

