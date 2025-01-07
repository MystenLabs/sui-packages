module 0xa78c8d00d1461a486e08a6d72f8808bcd52ed784aff5ab78d57b37a9e3b38cd0::xxx1000 {
    struct XXX1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX1000>(arg0, 9, b"XXX1000", b"ReefSui", b"The best Reef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/808d4323-b327-45b6-9ec0-2c475445adcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX1000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XXX1000>>(v1);
    }

    // decompiled from Move bytecode v6
}

