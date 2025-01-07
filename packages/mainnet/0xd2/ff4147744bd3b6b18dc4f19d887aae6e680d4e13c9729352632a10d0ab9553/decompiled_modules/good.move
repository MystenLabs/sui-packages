module 0xd2ff4147744bd3b6b18dc4f19d887aae6e680d4e13c9729352632a10d0ab9553::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD>(arg0, 9, b"GOOD", b"Chiboy", b"I love sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1329119-13ef-454a-88b9-4bcd61738510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

