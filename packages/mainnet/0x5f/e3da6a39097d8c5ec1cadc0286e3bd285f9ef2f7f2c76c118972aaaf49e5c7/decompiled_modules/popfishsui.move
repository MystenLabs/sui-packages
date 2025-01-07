module 0x5fe3da6a39097d8c5ec1cadc0286e3bd285f9ef2f7f2c76c118972aaaf49e5c7::popfishsui {
    struct POPFISHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFISHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFISHSUI>(arg0, 6, b"POPFISHSUI", b"POPFISH", x"504f5020504f5020504f5020504f5020504f5020504f500a0a504f5020504f5020504f5020504f5020504f5020504f500a0a504f5020504f5020504f5020504f5020504f5020504f500a0a504f5020504f5020504f5020504f5020504f5020504f500a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xbe2c79c5f3e165518e3b3a420a4e35c134e87d8d0f6034ecb5b633f02dd935c_popfish_popfish_7252efe090.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFISHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

