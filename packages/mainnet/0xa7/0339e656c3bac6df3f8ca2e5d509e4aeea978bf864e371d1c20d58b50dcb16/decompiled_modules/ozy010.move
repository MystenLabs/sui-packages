module 0xa70339e656c3bac6df3f8ca2e5d509e4aeea978bf864e371d1c20d58b50dcb16::ozy010 {
    struct OZY010 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZY010, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZY010>(arg0, 9, b"OZY010", b"OZY", b"Of all the people I've lost the one I miss the most is myself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/867bc3aa-7293-47d5-8ff0-fcafa56073a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZY010>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZY010>>(v1);
    }

    // decompiled from Move bytecode v6
}

