module 0xdbde21485703a741e9008a134ec56ce4c8e7b383b3124d57986eb9fdb3135bbd::lemug01 {
    struct LEMUG01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMUG01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMUG01>(arg0, 9, b"LEMUG01", b"GIGGLEMUG", b"pretty joyful laughing meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dacb0784-7a02-4203-95e3-316f85714890.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMUG01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMUG01>>(v1);
    }

    // decompiled from Move bytecode v6
}

