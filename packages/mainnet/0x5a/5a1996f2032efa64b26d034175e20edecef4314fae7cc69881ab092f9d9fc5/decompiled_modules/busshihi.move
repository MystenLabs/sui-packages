module 0x5a5a1996f2032efa64b26d034175e20edecef4314fae7cc69881ab092f9d9fc5::busshihi {
    struct BUSSHIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSSHIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSSHIHI>(arg0, 9, b"BUSSHIHI", b"BusBus", b"Buss nhes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eea0c9f-36aa-4a18-9e37-a11f87e89f58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSSHIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUSSHIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

