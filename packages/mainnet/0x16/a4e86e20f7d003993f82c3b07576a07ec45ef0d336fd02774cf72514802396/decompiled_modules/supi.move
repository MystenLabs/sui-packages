module 0x16a4e86e20f7d003993f82c3b07576a07ec45ef0d336fd02774cf72514802396::supi {
    struct SUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPI>(arg0, 9, b"SUPI", b"SUIPANDA", b" dives into the digital seas of the Sui network, hunting shiny Sui coinsWearing a diving maskhe chases them like fish, collecting each in his digital treasure chest Known as the best coin hunter SUPI proves that patience and humor win the", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d1fdcb9-0161-40ac-839c-8789db1cd1a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

