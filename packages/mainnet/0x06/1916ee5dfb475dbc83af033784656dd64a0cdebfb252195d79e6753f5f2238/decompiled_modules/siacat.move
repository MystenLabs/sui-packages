module 0x61916ee5dfb475dbc83af033784656dd64a0cdebfb252195d79e6753f5f2238::siacat {
    struct SIACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIACAT>(arg0, 9, b"SIACAT", b"Siaavokhsh", b"Siacat send to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6f06870-e1ce-4b19-b016-06d78c2ecf2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

